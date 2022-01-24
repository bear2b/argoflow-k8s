# argoflow-k8s
Keeps all the configs needed to deploy Argoflow to Kubernetes

### HELM
We use HELM to deploy Argoflow to Kubernetes. Please follow instructions https://helm.sh/docs/intro/install/ to install HELM.

### Prepare configuration files

API Config example:
```json
{
  "host": "k8s-api.your-domain.com",
  "port": 80,
  "protocol": "https",
  "jwt": {
    "secret": "<JWT secret>",
    "algo": "HS256"
  },
  "mongoDB": {
    "connectionString": "mongodb://mongo-service:27017/creator"
  },
  "redis": {
    "port": 6379,
    "host": "redis-service",
    "ipInfoKeyPrefix": "argoflow::ipinfo::"
  },
  "shortIo": {
    "secretKey": "<short.io token>"
  },
  "storageUsed": "local",
  "storages": {
    "local": {
      "rootFolder": "/storage/files",
      "filesUrl": "https://k8s-files.your-domain.com"
    }
  }
}
```
In the config above you need to put your desired api url to `host` parameter and files url to `storages.local.filesUrl`. \
You can also put short.io secret key to `shortIo.secretKey` if you plan to use short links.

As soon as API config prepared, it should be converted to base64 string and saved to `./helm/templates/00_secrets.yaml` to `AF_API_CONFIG_B64` secret.

You also need to put appropriate information to `./heml/values.development.yaml` and/or `./heml/values.production.yaml`.

### Deploy Argoflow:
```bash
cd helm
helm install -n argoflow -f values.development.yaml -f values.yaml argoflow .
```
### Update
```bash
cd helm
helm upgrade -n argoflow -f values.development.yaml -f values.yaml argoflow .
```

### Create initial Mongo database
```bash
kubectl cp -n argoflow ./initial/initial.archive mongo-0:/tmp
kubectl exec -it mongo-0 -n argoflow -- mongorestore --archive=/tmp/initial.archive
```
In the initial database you'll have a super admin: `initial-superadmin@argoflow.io` Password:`3NXEsMZCnhWSSt2aALny6jXh`

Don't forget to set your organisation subdomain for smartlinks. E.g. for `k8s-sl.your-domain.com` it should be:
```bash
db.organization.updateOne({"_id" : ObjectId("60644de18da0a703e87b78b6")},{$set:{sub:"k8s-sl"}});
```
### Prepare Statistical stack
```bash
kubectl exec -it pod/kafka-0 -n argoflow -- kafka-topics --zookeeper "zookeeper-service:2181" --topic wizeflow.tracks --create --partitions 10 --replication-factor 1 --config retention.bytes=10485760 retention.ms=86400000 cleanup.policy=delete

kubectl exec -it pod/clickhouse-0 -n argoflow -- clickhouse-client -q "$(cat ../initial/clickhouse/initial.sql)" -n
```

# Argoflow Editor
Please set your domains in `allowedDomainsList` settings in `./helm/values.development.yaml` file.

### DNS settings
|Type |Name       |Content (Example!!!)                                                  |Description                    |
|-----|-----------|----------------------------------------------------------------------|-------------------------------|
|CNAME|k8s-track  |a2adf2e3c0d2941e7adf2d427d4f8e59-173201457.eu-west-1.elb.amazonaws.com|service/kafka-proxy-service    |
|CNAME|k8s-api    |ab0534a036516474a8c30a1c1ad108ce-835617766.eu-west-1.elb.amazonaws.com|service/api-service            |
|CNAME|k8s-files  |aaaf0a7b4549a47161777cd3c3dcf738-118774766.eu-west-1.elb.amazonaws.com|service/files-service          |
|CNAME|k8s-sl     |a1de7ecc3416b4c269b3f780a2ef327a-166117620.eu-west-1.elb.amazonaws.com|service/service/sl-service     |
|CNAME|k8s-scripts|a1de7ecc3416b4c269b3f780a2ef327a-166117620.eu-west-1.elb.amazonaws.com|service/service/sl-service     |
|CNAME|k8s-editor |acf97cabf51574b8b9a0c9d329b8ca0c-913952360.eu-west-1.elb.amazonaws.com|service/service/editor-service |
|CNAME|k8s-manager|ab0959c9c30d548949c0db3e2e85d3aa-463871674.eu-west-1.elb.amazonaws.com|service/service/manager-service|
