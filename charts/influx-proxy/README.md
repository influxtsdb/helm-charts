# InfluxDB Proxy Helm chart

[InfluxDB Proxy](https://github.com/chengshiwen/influx-proxy) adds a basic high availability and consistent hash layer to [InfluxDB](https://github.com/influxdata/influxdb).

The InfluxDB Proxy Helm chart uses the [Helm](https://helm.sh) package manager to
bootstrap an InfluxDB Proxy StatefulSet and service on a
[Kubernetes](http://kubernetes.io) cluster.

## Prerequisites

- Helm v3 or later
- Kubernetes 1.4+
- (Optional) PersistentVolume (PV) provisioner support in the underlying infrastructure

## Install the chart

1. Get the InfluxDB Proxy Helm chart:

   ```bash
   git clone https://github.com/influxtsdb/helm-charts.git
   cd helm-charts/charts
   ```

2. Run the following command, providing a name for your InfluxDB Proxy release:

   ```bash
   helm upgrade --install my-release ./influx-proxy
   ```

   > **Tip**: `--install` can be shortened to `-i`.

   This command deploys InfluxDB Proxy on the Kubernetes cluster using the default configuration.

  > **Tip**: To view all Helm chart releases, run `helm list`.

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

The [InfluxDB Proxy](https://hub.docker.com/r/chengshiwen/influx-proxy) image stores cache data in the `/var/lib/influx-proxy` directory in the container.

If persistence is enabled, a [Persistent Volume](http://kubernetes.io/docs/user-guide/persistent-volumes/)
associated with StatefulSet is provisioned. The volume is created using dynamic
volume provisioning. In case of a disruption (for example, a node drain),
Kubernetes ensures that the same volume is reattached to the Pod, preventing any
data loss. However, when persistence is **not enabled**, InfluxDB Proxy data is stored
in an empty directory, so if a Pod restarts, data is lost.

## Configuration

Please refer to [Proxy Configuration](https://github.com/chengshiwen/influx-proxy#proxy-configuration) and modify [configmap.yaml](./templates/configmap.yaml):
