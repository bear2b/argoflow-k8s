To migrate from 2.21 to 2.22 you need to perform following steps:
1. Add a new environment variable to the `sso` deployment (after `SSO_GAR_ENABLED`):
```yaml
- name: SSO_AIR_TABLE_ENABLED
  value: "{{ .Values.sso.parameters.airTable.airTableEnabled }}"
```
It should look like this:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sso
  namespace: argoflow
spec:
  ... # Other specs, not changed
  template:
    ... # Some metadata, not changed
    spec:
      containers:
      - name: {{ .Values.sso.name }}
        env:
        ...  # Other envs, not changed
        - name: SSO_GAR_ENABLED
          value: "{{ .Values.sso.parameters.gar.garEnabled }}"
        - name: SSO_AIR_TABLE_ENABLED                                          # New lines
          value: "{{ .Values.sso.parameters.airTable.airTableEnabled }}"       # New lines
      imagePullSecrets:
      - name: regcred
```

2. Update your **values.*.yaml** file. Add a new value to the `sso.parameters` section (after `gar`):
```yaml
airTable:
  airTableEnabled: false
```
It should look like this:
```yaml
sso:
  replicaCount: 1
  host: <host of your sso service>
  parameters:
    ... # Other parameters, not changed
    gar:
      garEnabled: false
    airTable:                    # New line
      airTableEnabled: false     # New line
  image:
    repository: argoteam/sso2
    pullPolicy: Always
  resources:
    {}
```

3. Change the **target port** of your `editor-service` (**45_editor.yaml**, line 69 in our example) from 4445 to 80:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: editor-service
  namespace: {{ .Values.namespace }}
spec:
  type: ClusterIP
  ports:
  - port: 8195
    targetPort: 80
  selector:
    name: {{ .Values.editor.name }}
```

3. Change the tag of your `clickhouse-proxy` service to `argoteam/clickhouse-proxy:1.5` (**40_stats.yaml**, line 85 in our example)

4. Copy sql scripts from (clickhouse)[https://github.com/bear2b/argoflow-k8s/tree/master/migration/2.22/clickhouse] folder to the clickhouse pod:
```bash
kubectl -it -n argoflow exec pod/<your clickhouse pod name> -- mkdir -p /argoflow
kubectl cp -n argoflow migration/2.22/clickhouse/. <your clickhouse pod name>:/argoflow/.
```

5. Go to Clickhouse pod and execute scripts from /clickhouse folder
```bash
kubectl exec -it -n argoflow <your clickhouse pod name> -- bash
cd /argoflow
clickhouse-client --multiquery < 00_ISETO-178-Statistics-timezone-fix.sql 2>&1 | tee -a 00_ISETO-178-Statistics-timezone-fix.txt
```

6. Do `helm upgrade`

7. Done
