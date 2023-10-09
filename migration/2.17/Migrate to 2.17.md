To migrate from 2.16 to 2.17 you need to perform following steps:

1. Not required but recommended: Check the **/helm/templates/45_editor.yaml** file and add new lines related to app-config.json file
2. We decided to get rid of kafka in our stats-stack. Update your **/helm/templates/40_stats.yaml** file. You need to make the following changes:
- Delete **"zookeeper-service"**, **"kafka-service"** and **"kafka-proxy-service"** Service blocks
- Delete **"zookeeper"**, **"kafka"** StatefulSet blocks and **"kafka-proxy"** Deployment block
- Add the following blocks:
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: clickhouse-bulk
  namespace: argoflow
spec:
  replicas: 1
  serviceName: clickhouse-bulk-service
  selector:
    matchLabels:
      component: clickhouse-bulk
  template:
    metadata:
      labels:
        component: clickhouse-bulk
    spec:
      containers:
      - name: clickhouse-bulk
        image: nikepan/clickhouse-bulk:1.3.7
        ports:
        - name: tcp
          containerPort: 8124
        env:
        - name: CLICKHOUSE_SERVERS
          value: "http://clickhouse-service:8123"
        - name: CLICKHOUSE_FLUSH_COUNT
          value: "10000"
        - name: CLICKHOUSE_FLUSH_INTERVAL
          value: "1000"
        - name: DUMP_CHECK_INTERVAL
          value: "300"
        - name: CLICKHOUSE_DOWN_TIMEOUT
          value: "60"
        - name: CLICKHOUSE_CONNECT_TIMEOUT
          value: "10"

---
apiVersion: v1
kind: Service
metadata:
  name: clickhouse-bulk-service
  namespace: argoflow
spec:
  type: LoadBalancer
  selector:
    component: clickhouse-bulk
  ports:
    - name: tcp
      port: 8124
      targetPort: 8124


---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: clickhouse-proxy
  namespace: argoflow
spec:
  selector:
    matchLabels:
      component: clickhouse-proxy
  replicas: 1
  template:
    metadata:
      labels:
        component: clickhouse-proxy
    spec:
      containers:
      - name: clickhouse-proxy
        image: argoteam/clickhouse-proxy:dev
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
        ports:
        - name: tcp
          containerPort: 80
        - name: udp
          containerPort: 8091
        env:
        - name: CLICKHOUSE_INGESTOR
          value: "http://clickhouse-bulk-service:8124"

---
apiVersion: v1
kind: Service
metadata:
  name: clickhouse-proxy-service
  namespace: argoflow
spec:
  type: LoadBalancer
  selector:
    component: clickhouse-proxy
  ports:
    - name: tcp
      port: 80
      targetPort: 80
    - name: udp
      port: 8091
      targetPort: 8091
```
- Compare your file with our one to be sure that you did all the changes correctly
3. Copy sql scripts from (clickhouse)[https://github.com/bear2b/argoflow-k8s/tree/master/migration/2.17/clickhouse] folder to the clickhouse pod:
```bash
kubectl -it -n argoflow exec pod/<your clickhouse pod name> -- mkdir -p /argoflow
kubectl cp -n argoflow migration/2.17/clickhouse/. <your clickhouse pod name>:/argoflow/.
```
4. Go to Clickhouse pod and execute scripts from /argoflow folder **one-by-one**
```bash
kubectl exec -it -n argoflow <your clickhouse pod name> -- bash
cd /argoflow
clickhouse-client --multiquery < 00_views.sql 2>&1 | tee -a 00_views_result.txt
clickhouse-client --multiquery < 01_views_cleanup.sql 2>&1 | tee -a 01_views_cleanup_result.txt
clickhouse-client --multiquery < 02_detail_view_smarltinks.sql 2>&1 | tee -a 02_detail_view_smarltinks.txt
```
5. Copy js scripts from (mongo)[https://github.com/bear2b/argoflow-k8s/tree/master/migration/2.17/mongo] folder to the mongo pod:
```bash
kubectl -it -n argoflow exec pod/<your mongo pod name> -- mkdir -p /argoflow
kubectl cp -n argoflow migration/2.17/mongo/. <your mongo pod name>:/argoflow/.
```
6. Go to Mongo pod and execute scripts from /argoflow folder **one-by-one**
```bash
kubectl exec -it -n argoflow <your mongo pod name> -- bash
cd /argoflow
mongo
load('00_asset_name.js')
exit
```
7. Do `helm upgrade`
8. Don't forget to update the CNAME record of your domain that led to **kafka-proxy-service** before. It should lead to **clickhouse-proxy-service** now