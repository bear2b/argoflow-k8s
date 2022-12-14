To migrate from `2.14` to `2.15` you can perform following steps:

1. Change Argoflow API config:
- Get current config:
```bash
kubectl get secret af-api-secrets -o jsonpath="{.data.AF_API_CONFIG_B64}" -n argoflow | base64 -D | base64 -D ; echo "" > current.config.json
```
- Add following keys at the end of the API `current.config.json`:
```json
  "logging": {
    "url": "<to be set in final config>", // specify your stats kafka proxy service
    "actionTopic": "wizeflow.actions",
    "errorTopic": "wizeflow.errors"
  },
  "emailerUsed": "argo",
  "emailers": {
    "argo": {
      "projectCode": "af",
      "transactionalEmailsTopic": "transactional.emails",
      "resetPasswordUiUrl": "<to be set in final config>", // specify you UI reset password page. Should contain {code} and {languageId} placeholders. If you use ARGO Manager then just replace your host in this string: https://argoflow.io/reset-password?security-code={code}&lang-id={languageId}
      "eventServerUrl": "<to be set in final config>" // specify your event kafka proxy service
    }
  }
```
- Encode current.config.json to base64:
```bash
base64 current.config.json
```
- Put encoded string (output of the previous command) to the values file (e.g. values.dev.jaml for dev) to `api:parameters:config64`

- Delete secret `af-api-secrets` (it will be recreated by `helm upgrade`):
```bash
kubectl delete secret af-api-secrets -n argoflow
```
- Do `helm upgrade`

2. SL Creator parameter has a new parameter in "values": `storageUrl` (`Values.smartlinkCreator.parameters.storageUrl`). This parameter should contain a public url of the storage server (e.g. `https://k8s-files.argoflow.io`).
3. Change `argoteam/kafka-proxy` version from `master` to `1.1` in `/helm/templates/40_stats.yaml` line 150. 
Do `helm upgrade`. Wait 5 minutes and go to next step
4. To let Argoflow 2.15 work properly, ClickHouse db should be upgraded to the version `22.9.3`.
ClickHouse upgrade can be done by migrating to next major version one by one until the required `22.9.3`.
Argoflow `2.14` works with ClickHouse `19.3`. So you can upgrade Clickhouse to version `20.8`, then to version `21.3` and finally to the `22.9.3`. To do this you can perform following steps:
- 4.1. Change version from `19.3` to `20.8` in `/helm/templates/40_stats.yaml` line 217. Do `helm upgrade`. Wait 5 minutes and check if ClickHouse pod works and statistics displayed in the Manager.
- 4.2. Change version from `20.8` to `21.3` in `/helm/templates/40_stats.yaml` line 217. Do `helm upgrade`. Wait 5 minutes and check if ClickHouse pod works and statistics displayed in the Manager.
- 4.3. Change version from `yandex/clickhouse-server:21.3` to `clickhouse/clickhouse-server:22.9.3` in `/helm/templates/40_stats.yaml` line 217.
Please note that the repository name changed from `yandex` to `clickhouse`.
Do `helm upgrade`. Wait 5 minutes and check if ClickHouse pod works and statistics displayed in the Manager.
5. Copy sql scripts from (scripts)[https://github.com/bear2b/argoflow-k8s/tree/master/migration/2.15/clickhouse] folder to the clickhouse pod:
```bash
kubectl -it -n argoflow exec pod/<your clickhouse pod name> -- mkdir -p /argoflow
kubectl cp -n argoflow scripts/. <your clickhouse pod name>:/argoflow/.
```
6. Go to Clickhouse pod and execute all scripts from /argoflow folder **one-by-one**
```bash
kubectl exec -it -n argoflow <your clickhouse pod name> -- bash
cd /argoflow
clickhouse-client --multiquery < 01_actions.sql 2>&1 | tee -a 01_actions_result.txt
clickhouse-client --multiquery < 02_errors.sql 2>&1 | tee -a 02_errors_result.txt
clickhouse-client --multiquery < 03_views.sql 2>&1 | tee -a 03_views_result.txt
clickhouse-client --multiquery < 04_dictionary_smarltinks.sql 2>&1 | tee -a 04_dictionary_smarltinks_result.txt
```
7. Do `helm upgrade`
