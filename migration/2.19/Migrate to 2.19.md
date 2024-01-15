To migrate from 2.18 to 2.19 you need to perform following steps:
1. Create a service user in Argoflow API. User must be a superadmin and must never be deleted. 
Please get user's token when it is created (don't forget to replace <argoflow api url>, <service user email> and <service user password> with appropriate values):
```bash
curl -X 'POST' \
  '<argoflow api url>/auth' \
  -H 'accept: */*' \
  -H 'Content-Type: multipart/form-data' \
  -F 'email=<service user email>' \
  -F 'password=<service user password>' \
  -F 'service=true' | grep -o '"token":"[^"]*' | grep -o '[^"]*$'
```
Save the received token, we are going to use it on the next steps.

2. Change Argoflow API config:
- Get current config:
```bash
kubectl get secret af-api-secrets -o jsonpath="{.data.AF_API_CONFIG_B64}" -n argoflow | base64 -D | base64 -D > current.config.json
```
- Add following keys at the end of the API `current.config.json`:
```json
  "ssoModeEnabled": true,
  "masterPassword": "<your master password>" // Set your own master password. It should be a MD5 hash. E. g. 1777120362afe842fd7456bbe128834b
```
- Encode current.config.json to base64:
```bash
base64 -i current.config.json
```
- Put encoded string (output of the previous command) to the values file (e.g. values.dev.jaml for dev) to `api:parameters:config64`

- Delete secret `af-api-secrets` (it will be recreated by `helm upgrade`):
```bash
kubectl delete secret af-api-secrets -n argoflow
```
- Do `helm upgrade`

3. Please be sure that you updated your **helm/templates** folder with the following changes:
**00_secrets.yaml** - added a **sso-secret** config block
**55_mysql.yaml** - new file, just put it to your **helm/templates** folder
**60_sso.yaml** - new file, just put it to your **helm/templates** folder
**50_manager.yaml** - change **"ssoEnabled"** value to **true** on 15 line of config (app-config.json) and add a new line after the property:
```yaml
"ssoUrl" : "{{ .Values.sso.host }}/api/v2",
```

4. Update your **values.*.yaml** file. Add the following values block to your file and set desired values (we commented values that should be changed):
```yaml
sso:
  replicaCount: 1
  host: <host of your sso service> # host of the service. E. g. k8s-sso.argoflow.io. Assign this domain name to the load balancer of sso service after creation
  parameters:
    jwtSecret: <your jwt secret> # your own JWT secret. E. g. 8AAmJ6Xf+doM7ZLoYiME22M8z61Df/VuIN8zsAWO6rc=
    masterPassword: <your master password> # the same master password as you specified previously in the Argoflow API config. But it should be a plain string here, NOT an MD5 hash
    mysqlLogin: root
    mysqlPassword: <mysql password> # set your own mysql password
    issuer: <your issuer host> # change to your own issuer host. E. g. k8s-sso.argoflow.io
    mysql:
      host: mysql-service
      port: 3306
      database: sso
    checkSession: false
    eventServer:
      host: https://statsdev.bear2b.com
    gar:
      garEnabled: false
  image:
    repository: argoteam/sso2
    pullPolicy: Always
  resources:
    {}
```

5. Do `helm upgrade`

6. Copy sql script from (mysql)[https://github.com/bear2b/argoflow-k8s/tree/master/migration/2.19/mysql] folder to the mysql pod:
```bash
kubectl -it -n argoflow exec pod/<your mysql pod name> -- mkdir -p /argoflow
kubectl cp -n argoflow migration/2.19/mysql/. <your mysql pod name>:/argoflow/.
```

7. Go to mysql pod and execute scripts from /mysql folder
```bash
kubectl exec -it -n argoflow <your mysql pod name> -- bash
cd /argoflow
mysql -u root -p sso < 00_initial_sso.sql

# Please replace in the following lines "<argoflow api url>" to your Argoflow API url. (E. g. https://k8s-api.argoflow.io)
# And "<argoflow api token>" to your Argoflow API service token that you received in the first step of this migration guide
mysql -u root -p -e "update sso.products set api = '<argoflow api url>', token = '<argoflow api token>' where code = 'wapi'"
mysql -u root -p -e "update sso.applications set ui_url = '<argoflow api url>', ui_password_reset_url = '<argoflow api url>/set-new-password?security-code=%s' where id = 3"
```

8. Copy js scripts from (mongo)[https://github.com/bear2b/argoflow-k8s/tree/master/migration/2.19/mongo] folder to the mongo pod:
```bash
kubectl -it -n argoflow exec pod/<your mongo pod name> -- mkdir -p /argoflow
kubectl cp -n argoflow migration/2.19/mongo/. <your mongo pod name>:/argoflow/.
```

9. Go to Mongo pod and execute scripts from /argoflow folder **one-by-one**
```bash
kubectl exec -it -n argoflow <your mongo pod name> -- bash
cd /argoflow
mongo
load('00_tags_view.js')
load('01_member_organization_created.js')
exit
```

10. Check the SSO pod. If it's stopped with any error then just delete it to recreate it again:
```bash
kubectl delete pod <your sso pod> -n argoflow
```

11. Now you can synchronise Argoflow API users with SSO.
Please run the following commands one by one (replace **<url of your sso service>** to your sso service url. E. g. **https://k8s-sso.argoflow.io**):
```bash
token=$(curl -X 'POST' \
  '<url of your sso service>/api/v2/auth/token' \
  -H 'accept: application/json' \
  -H 'Content-Type: multipart/form-data' \
  -F 'email=argoflow-migration-super-admin@ar-go.co' \
  -F 'password=yy26e9xDLKe8pXtN' \
  -F 'ttl=604800' \
  -F 'access=full' \
  -F 'type=normal' \
  -F 'application_id=3' | grep -o '"token":"[^"]*' | grep -o '[^"]*$')

curl -X 'GET' \
  '<url of your sso service>/api/v2/organizations/sync' \
  -H 'accept: application/json' \
  -H 'Authorization: '$token
```