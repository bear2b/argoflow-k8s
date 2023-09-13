To migrate from 2.17 to 2.18 you need to perform following steps:
1. Please do the following steps in your **40_stats.yaml** file:
- change version of **clickhouse-bulk** image from **nikepan/clickhouse-bulk:1.3.7** to **nikepan/clickhouse-bulk:1.3.8**
- change the value of `CLICKHOUSE_DOWN_TIMEOUT` environment variable from **60** to **180** (**clickhouse-bulk** service)
- change the version of **clickhouse-server** image from **clickhouse/clickhouse-server:22.9.3** to **clickhouse/clickhouse-server:23.7.4**
2. Do `helm upgrade`