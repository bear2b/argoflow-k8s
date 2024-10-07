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

3. Do `helm upgrade`

4. Done
