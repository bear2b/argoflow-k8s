To migrate from 2.14 to 2.15 you need to perform following steps:

1. Fill out new fields in the config (check config.default.json file to learn more):
```json
{
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
}
```
2. To let Argoflow 2.15 work properly, ClickHouse db should be upgraded to the version 22.9.3.
ClickHouse upgrade can be done by migrating to next major version one by one until the required 22.9.3.
Argoflow 2.14 works with ClickHouse 19.3. So you can upgrade Clickhouse to version 20.8, then to version 21.3 and finally to version 22.9.3. To do this you can perform following steps:
2.1. Change version from 19.3 to 20.8 in /helm/templates/40_stats.yaml line 217. Do helm upgrade. Wait 5 minutes and check if ClickHouse pod works and statistics displayed in the Manager.
2.2. Change version from 20.8 to 21.3 in /helm/templates/40_stats.yaml line 217. Do helm upgrade. Wait 5 minutes and check if ClickHouse pod works and statistics displayed in the Manager.
2.3. Change version from yandex/clickhouse-server:21.3 to clickhouse/clickhouse-server:22.9.3 in /helm/templates/40_stats.yaml line 217.
Please note that the repository name changed from yandex to clickhouse.
Do helm upgrade. Wait 5 minutes and check if ClickHouse pod works and statistics displayed in the Manager.
3. Go to Clickhouse pod
4. Get .sql files in the "clickhouse" folder next to this file. Execute following commands one-by-one using those files:

```bash
clickhouse-client --multiquery < 01_actions.sql | tee -a 01_actions_result.txt
clickhouse-client --multiquery < 02_errors.sql | tee -a 02_errors_result.txt
clickhouse-client --multiquery < 03_views.sql | tee -a 03_views_result.txt
clickhouse-client --multiquery < 04_dictionary_smarltinks.sql | tee -a 04_dictionary_smarltinks_result.txt
```