To migrate from 2.20 to 2.21 you need to perform following steps:
1. Copy sql scripts from (clickhouse)[https://github.com/bear2b/argoflow-k8s/tree/master/migration/2.21/clickhouse] folder to the clickhouse pod:
```bash
kubectl -it -n argoflow exec pod/<your clickhouse pod name> -- mkdir -p /argoflow
kubectl cp -n argoflow migration/2.21/clickhouse/. <your clickhouse pod name>:/argoflow/.
```

2. Go to Clickhouse pod and execute scripts from /clickhouse folder
```bash
kubectl exec -it -n argoflow <your clickhouse pod name> -- bash
cd /argoflow
clickhouse-client --multiquery < 00_WAPI_894_tracks_asset_original_filename.sql 2>&1 | tee -a 00_WAPI_894_tracks_asset_original_filename.txt
clickhouse-client --multiquery < 01_WAPI_887_visitor_emails.sql 2>&1 | tee -a 01_WAPI_887_visitor_emails.txt
```

3. Do `helm upgrade`

4. Done
