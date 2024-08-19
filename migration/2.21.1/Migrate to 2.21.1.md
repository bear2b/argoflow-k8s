This version is dedicated to Clickhouse proxy changes.

To migrate the `clickhouse-proxy` to a new version you need to perform following steps:

- Add `CLICKHOUSE` environment variable `helm/templates/40_stats.yaml` to `clickhouse-proxy` section.

E.g.:
```yaml
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
        image: argoteam/clickhouse-proxy:1.2
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
        - name: CLICKHOUSE_INGESTOR__DISABLED
          value: "http://clickhouse-bulk-service:8124"
        - name: CLICKHOUSE
          value: "clickhouse-service:9000"
```

- Rename `CLICKHOUSE_INGESTOR` to `CLICKHOUSE_INGESTOR__DISABLED` in `helm/templates/40_stats.yaml` in `clickhouse-proxy` section. 
Renaming this variable back to `CLICKHOUSE_INGESTOR` (and removing `CLICKHOUSE`) will let you switch back to clickhouse-bulk in case of any issues with new approach.

- Change `image: argoteam/clickhouse-proxy:dev` to `image: argoteam/clickhouse-proxy:1.2` in `helm/templates/40_stats.yaml` in `clickhouse-proxy` section.

- Do `helm upgrade`

- Done
