# InfluxTSDB Helm charts

[![License](https://img.shields.io/badge/license-MIT-green.svg)](./LICENSE)
[![](https://github.com/influxtsdb/helm-charts/workflows/helm-charts%2Frelease/badge.svg?branch=master)](https://github.com/influxtsdb/helm-charts/actions)

## Usage

1. Install [Helm](https://helm.sh). For more information, see [Helm documentation](https://helm.sh/docs/).

2. Install [Chart](./charts):

   ```bash
   git clone https://github.com/influxtsdb/helm-charts.git
   cd helm-charts/charts
   # install influx-proxy
   helm install influx-proxy ./influx-proxy
   # install influxdb-cluster
   helm install influxdb-cluster ./influxdb-cluster
   # install influxdb-admin
   helm install influxdb-admin ./influxdb-admin
   ```

## Charts

- [influx-proxy](./charts/influx-proxy): Helm chart for [InfluxDB Proxy](https://github.com/chengshiwen/influx-proxy), a Layer to InfluxDB with High Availability and Consistent Hash
- [influxdb-cluster](./charts/influxdb-cluster): Helm chart for [InfluxDB Cluster](https://github.com/chengshiwen/influxdb-cluster), Open Source Alternative to InfluxDB Enterprise
- [influxdb-admin](./charts/influxdb-admin): Helm chart for [InfluxDB Admin](https://github.com/influxtsdb/influxdb-admin), InfluxDB Web Admin Interface

## Support

These Helm charts are community supported. InfluxTSDB provides no official support for their use.

Pull requests and issues are the responsibility of the project's moderator(s) which may include vetted individuals outside of the
InfluxTSDB organization. All issues should be reported and managed via GitHub (not via InfluxTSDB's standard support process).

## License

[MIT License](./LICENSE)
