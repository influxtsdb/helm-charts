# InfluxDB Admin Helm chart

[InfluxDB Admin](https://github.com/influxtsdb/influxdb-admin) is an [InfluxDB](https://docs.influxdata.com/influxdb/v1.8/) Web Admin Interface.

The InfluxDB Admin Helm chart uses the [Helm](https://helm.sh) package manager to
bootstrap an InfluxDB Admin StatefulSet and service on a
[Kubernetes](http://kubernetes.io) cluster.

## Prerequisites

- Helm v3 or later
- Kubernetes 1.4+

## Install the chart

1. Get the InfluxDB Admin Helm chart:

   ```bash
   git clone https://github.com/influxtsdb/helm-charts.git
   cd helm-charts/charts
   ```

2. Run the following command, providing a name for your InfluxDB Admin release:

   ```bash
   helm upgrade --install my-release ./influxdb-admin
   ```

   > **Tip**: `--install` can be shortened to `-i`.

   This command deploys InfluxDB Admin on the Kubernetes cluster using the default configuration.

  > **Tip**: To view all Helm chart releases, run `helm list`.

## Uninstall the chart

To uninstall the `my-release` deployment, use the following command:

```bash
helm uninstall my-release
```

This command removes all Kubernetes components.
