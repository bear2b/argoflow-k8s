To migrate from 2.16 to 2.17 you need to perform following steps:

1. Copy sql scripts from (clickhouse)[https://github.com/bear2b/argoflow-k8s/tree/master/migration/2.17.1/clickhouse] folder to the clickhouse pod:
```bash
kubectl -it -n argoflow exec pod/<your clickhouse pod name> -- mkdir -p /argoflow
kubectl cp -n argoflow migration/2.17.1/clickhouse/. <your clickhouse pod name>:/argoflow/.
```
2. Go to Clickhouse pod and execute scripts from /argoflow folder **one-by-one**
```bash
kubectl exec -it -n argoflow <your clickhouse pod name> -- bash
cd /argoflow
clickhouse-client --multiquery < 00_views.sql 2>&1 | tee -a 00_views_result.txt
```
3. Do `helm upgrade`