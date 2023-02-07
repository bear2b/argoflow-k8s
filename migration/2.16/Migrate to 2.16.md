To migrate from 2.15 to 2.16 you need to perform following steps:

1. Copy sql scripts from (clickhouse)[https://github.com/bear2b/argoflow-k8s/tree/master/migration/2.16/clickhouse] folder to the clickhouse pod:
```bash
kubectl -it -n argoflow exec pod/<your clickhouse pod name> -- mkdir -p /argoflow
kubectl cp -n argoflow migration/2.16/clickhouse/. <your clickhouse pod name>:/argoflow/.
```
2. Go to Clickhouse pod and execute a scripts from /argoflow folder **one-by-one**
```bash
kubectl exec -it -n argoflow <your clickhouse pod name> -- bash
cd /argoflow
clickhouse-client --multiquery < 01_views.sql 2>&1 | tee -a 01_views_result.txt
```
3. Do `helm upgrade`