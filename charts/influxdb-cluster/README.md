# InfluxDB Cluster Helm chart

[InfluxDB Cluster](https://github.com/chengshiwen/influxdb-cluster) is an open-source distributed time series database and open source alternative to [InfluxDB Enterprise](https://docs.influxdata.com/enterprise_influxdb/v1.8/).

The InfluxDB Cluster Helm chart uses the [Helm](https://helm.sh) package manager to
bootstrap an InfluxDB Cluster StatefulSet and service on a
[Kubernetes](http://kubernetes.io) cluster.

## Prerequisites

- Helm v3 or later
- Kubernetes 1.4+
- (Optional) PersistentVolume (PV) provisioner support in the underlying infrastructure

## Install the chart

1. Get the InfluxDB Cluster Helm chart:

   ```bash
   git clone https://github.com/influxtsdb/helm-charts.git
   cd helm-charts/charts
   ```

2. Run the following command, providing a name for your InfluxDB Cluster release:

   ```bash
   helm upgrade --install my-release ./influxdb-cluster
   ```

   > **Tip**: `--install` can be shortened to `-i`.

   This command deploys InfluxDB Cluster on the Kubernetes cluster using the default configuration.

  > **Tip**: To view all Helm chart releases, run `helm list`.

## Join nodes to cluster

```bash
kubectl exec -it influxdb-cluster-meta-0 bash
influxd-ctl add-meta influxdb-cluster-meta-0.influxdb-cluster-meta-headless:8091
influxd-ctl add-meta influxdb-cluster-meta-1.influxdb-cluster-meta-headless:8091
influxd-ctl add-meta influxdb-cluster-meta-2.influxdb-cluster-meta-headless:8091
influxd-ctl add-data influxdb-cluster-data-0.influxdb-cluster-data-headless:8088
influxd-ctl add-data influxdb-cluster-data-1.influxdb-cluster-data-headless:8088
influxd-ctl show
```

### Create your first database

```
curl -XPOST "http://influxdb-cluster-data:8086/query" --data-urlencode "q=CREATE DATABASE mydb WITH REPLICATION 2"
```

### Insert some data

```
curl -XPOST "http://influxdb-cluster-data:8086/write?db=mydb" \
-d 'cpu,host=server01,region=uswest load=42 1434055562000000000'

curl -XPOST "http://influxdb-cluster-data:8086/write?db=mydb&consistency=all" \
-d 'cpu,host=server02,region=uswest load=78 1434055562000000000'

curl -XPOST "http://influxdb-cluster-data:8086/write?db=mydb&consistency=quorum" \
-d 'cpu,host=server03,region=useast load=15.4 1434055562000000000'
```

> **Note**: `consistency=[any,one,quorum,all]` sets the write consistency for the point. `consistency` is `one` if you do not specify consistency. See the [Insert some data / Write consistency](https://github.com/chengshiwen/influxdb-cluster/wiki/Home-Eng#insert-some-data) for detailed descriptions of each consistency option.

### Query for the data

```
curl -G "http://influxdb-cluster-data:8086/query?pretty=true" --data-urlencode "db=mydb" \
--data-urlencode "q=SELECT * FROM cpu WHERE host='server01' AND time < now() - 1d"
```

### Analyze the data

```
curl -G "http://influxdb-cluster-data:8086/query?pretty=true" --data-urlencode "db=mydb" \
--data-urlencode "q=SELECT mean(load) FROM cpu WHERE region='uswest'"
```

## Uninstall the chart

To uninstall the `my-release` deployment, use the following command:

```bash
helm uninstall my-release
```

This command removes all Kubernetes components but PVCs associated with the chart and deletes the release.

To delete the PVCs associated with `my-release`:

```bash
kubectl delete pvc -l app.kubernetes.io/instance=my-release
```

## Persistence

The [InfluxDB Cluster](https://hub.docker.com/r/chengshiwen/influxdb) image stores cache data in the `/var/lib/influxdb` directory in the container.

If persistence is enabled, a [Persistent Volume](http://kubernetes.io/docs/user-guide/persistent-volumes/)
associated with StatefulSet is provisioned. The volume is created using dynamic
volume provisioning. In case of a disruption (for example, a node drain),
Kubernetes ensures that the same volume is reattached to the Pod, preventing any
data loss. However, when persistence is **not enabled**, InfluxDB Cluster data is stored
in an empty directory, so if a Pod restarts, data is lost.

## Configuration

Please refer to [Configure Meta Nodes](https://github.com/chengshiwen/influxdb-cluster/wiki/Configure-Meta-Nodes) and [Configure Data Nodes](https://github.com/chengshiwen/influxdb-cluster/wiki/Configure-Data-Nodes).
And then modify [meta-configmap.yaml](./templates/meta-configmap.yaml) and [data-configmap.yaml](./templates/data-configmap.yaml).
