To migrate from 2.16 to 2.17 you need to perform following steps:

1. Not required but recommended: Check the /helm/templates/45_editor.yaml file and add new lines related to app-config.json file
2. Copy sql scripts from (clickhouse)[https://github.com/bear2b/argoflow-k8s/tree/master/migration/2.17/clickhouse] folder to the clickhouse pod:
```bash
kubectl -it -n argoflow exec pod/<your clickhouse pod name> -- mkdir -p /argoflow
kubectl cp -n argoflow migration/2.17/clickhouse/. <your clickhouse pod name>:/argoflow/.
```
3. Go to Clickhouse pod and execute scripts from /argoflow folder **one-by-one**
```bash
kubectl exec -it -n argoflow <your clickhouse pod name> -- bash
cd /argoflow
clickhouse-client --multiquery < 00_views.sql 2>&1 | tee -a 00_views_result.txt
```
4. Copy js scripts from (mongo)[https://github.com/bear2b/argoflow-k8s/tree/master/migration/2.17/mongo] folder to the mongo pod:
```bash
kubectl -it -n argoflow exec pod/<your mongo pod name> -- mkdir -p /argoflow
kubectl cp -n argoflow migration/2.17/mongo/. <your mongo pod name>:/argoflow/.
```
5. Go to Mongo pod and execute scripts from /argoflow folder **one-by-one**
```bash
kubectl exec -it -n argoflow <your mongo pod name> -- bash
cd /argoflow
mongo
load('00_asset_name.js')
exit
```
6. Do `helm upgrade`