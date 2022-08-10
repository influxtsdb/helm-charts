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
influxd-ctl add-meta influxdb-cluster-meta-0.influxdb-cluster-meta:8091
influxd-ctl add-meta influxdb-cluster-meta-1.influxdb-cluster-meta:8091
influxd-ctl add-meta influxdb-cluster-meta-2.influxdb-cluster-meta:8091
influxd-ctl add-data influxdb-cluster-data-0.influxdb-cluster-data:8088
influxd-ctl add-data influxdb-cluster-data-1.influxdb-cluster-data:8088
influxd-ctl show
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
