To migrate from 2.17 to 2.18 you need to perform following steps:
1. Please do the following steps in your **40_stats.yaml** file:
- change version of **clickhouse-bulk** image from **nikepan/clickhouse-bulk:1.3.7** to **nikepan/clickhouse-bulk:1.3.8**
- change the value of `CLICKHOUSE_DOWN_TIMEOUT` environment variable from **60** to **180** (**clickhouse-bulk** service)
- change the version of **clickhouse-server** image from **clickhouse/clickhouse-server:22.9.3** to **clickhouse/clickhouse-server:23.7.4**

2. Copy sql script from (clickhouse)[https://github.com/bear2b/argoflow-k8s/tree/master/migration/2.18/clickhouse] folder to the clickhouse pod:
```bash
kubectl -it -n argoflow exec pod/<your clickhouse pod name> -- mkdir -p /argoflow
kubectl cp -n argoflow migration/2.18/clickhouse/. <your clickhouse pod name>:/argoflow/.
```

3. Go to Clickhouse pod and execute script from /clickhouse folder
```bash
kubectl exec -it -n argoflow <your clickhouse pod name> -- bash
cd /argoflow
clickhouse-client --multiquery < 00_dict_smartlinks.sql 2>&1 | tee -a 00_dict_smartlinks.txt
clickhouse-client --multiquery < 01_detail_view_smarltinks.sql 2>&1 | tee -a 01_detail_view_smarltinks.txt
```

4. Do `helm upgrade`