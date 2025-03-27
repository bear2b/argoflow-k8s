To migrate from 2.22 to 2.23 you need to perform following steps:
1. Copy sql script from (mysql)[https://github.com/bear2b/argoflow-k8s/tree/master/migration/2.23/mysql] folder to the mysql pod:
```bash
kubectl -it -n argoflow exec pod/<your mysql pod name> -- mkdir -p /argoflow
kubectl cp -n argoflow migration/2.23/mysql/. <your mysql pod name>:/argoflow/.
```

2. Go to Mysql pod and execute scripts from /mysql folder
```bash
kubectl exec -it -n argoflow <your mysql pod name> -- bash
cd /argoflow
mysql -u root -p sso < 00_SSO_134_mfa.sql 2>&1 | tee -a 00_SSO_134_mfa.txt
mysql -u root -p sso < 01_SSO_126_not_empty_updated_at.sql 2>&1 | tee -a 01_SSO_126_not_empty_updated_at.txt
```

3. Do `helm upgrade`.