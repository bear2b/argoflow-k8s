To migrate from 2.19 to 2.20 you need to perform following steps:
1. [**Skip this step if you have already applied the 'clickhouse-bulk memory leak' fix**] 
Please do the following steps in your **40_stats.yaml** file:
- change version of **clickhouse-bulk** image from **nikepan/clickhouse-bulk:1.3.8** to **argoteam/clickhouse-bulk:1.0**
- Add a new environment variable with a value (spec.template.spec.containers[0].env level):
```yaml
- name: CLICKHOUSE_CLEAN_INTERVAL
  value: "30000"
```
- After “env“ block add a new one (spec.template.spec.containers[0] level):
```yaml
volumeMounts:
- name: clickhouse-bulk-persistent-volume
  mountPath: /app/dumps
  subPath: clickhouse_bulk
```
- After “template“ block add a new one (spec level):
```yaml
volumeClaimTemplates:
- metadata:
    name: clickhouse-bulk-persistent-volume
  spec:
    accessModes:
      - ReadWriteOnce
    resources:
      requests:
        storage: 5Gi
```
- Check the **40_stats.yaml** file in the /helm/template release folder to see how it should look finally. 

2. Copy sql script from (clickhouse)[https://github.com/bear2b/argoflow-k8s/tree/master/migration/2.20/clickhouse] folder to the clickhouse pod:
```bash
kubectl -it -n argoflow exec pod/<your clickhouse pod name> -- mkdir -p /argoflow
kubectl cp -n argoflow migration/2.20/clickhouse/. <your clickhouse pod name>:/argoflow/.
```

3. Go to Clickhouse pod and execute scripts from /clickhouse folder
```bash
kubectl exec -it -n argoflow <your clickhouse pod name> -- bash
cd /argoflow
clickhouse-client --multiquery < 00_dict_smartlinks.sql 2>&1 | tee -a 00_dict_smartlinks.txt
clickhouse-client --multiquery < 01_tracks_view_by_organization_id_dt.sql 2>&1 | tee -a 01_tracks_view_by_organization_id_dt.txt
```

4. Copy sql script from (mysql)[https://github.com/bear2b/argoflow-k8s/tree/master/migration/2.20/mysql] folder to the mysql pod:
```bash
kubectl -it -n argoflow exec pod/<your mysql pod name> -- mkdir -p /argoflow
kubectl cp -n argoflow migration/2.20/mysql/. <your mysql pod name>:/argoflow/.
```

5. Go to Mysql pod and execute scripts from /mysql folder
```bash
kubectl exec -it -n argoflow <your mysql pod name> -- bash
cd /argoflow
mysql -u root -p sso < 00_user_default_language.sql 2>&1 | tee -a 00_user_default_language.txt
```

6. Do `helm upgrade`. If you got the following error:
```bash
Error: UPGRADE FAILED: cannot patch "clickhouse-bulk" with kind StatefulSet: StatefulSet.apps "clickhouse-bulk" is invalid: spec: Forbidden: updates to statefulset spec for fields other than 'replicas', 'template', and 'updateStrategy' are forbidden.
```
Then follow these steps:
- Delete **clickhouse-bulk** and **clickhouse-bulk-service** blocks from **/helm/templates/40_stats.yaml** file
- run **helm upgrade** and wait for a while 
- Get those blocks back to file
- run **helm upgrade** again