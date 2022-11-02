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
2. We updated clickhouse version from 19.3 to 22.9 (last one). That is a big update. Check the `/helm/templates/40_stats.yaml` file, 217 line. You will find the last version tag there. Please, set the `yandex/clickhouse-server:20.8` image name and version tag first, start the service, check if clickhouse server is started and works. Repeat the same but with the `yandex/clickhouse-server:21.3` image and tag. And after that you can finally set the `clickhouse/clickhouse-server:22.9` image and tag

3. Go to Clickhouse pod
4. Run `clickhouse-client`
5. Execute following commands one-by-one:

```sql
USE wizeflow;


CREATE TABLE wizeflow.actions (
  dt DateTime,
  ms UInt32,
  rid String,
  ua Nullable(String),
  url Nullable(String),
  method Nullable(String),
  entity Nullable(String),
  entity_id Nullable(String),
  user_id Nullable(String),
  user_name Nullable(String),
  organization_id Nullable(String)
)
ENGINE = MergeTree() 
PARTITION BY toDate(dt)
ORDER BY (dt, ms, rid) 
SETTINGS index_granularity = 8192;

CREATE TABLE __kafka__wizeflow_actions AS actions ENGINE = Kafka()
SETTINGS 
kafka_broker_list='kafka-service:19092',
kafka_topic_list = 'wizeflow.actions',
kafka_group_name = 'ch.wizeflow.actions',
kafka_format = 'JSONEachRow',
kafka_skip_broken_messages = 1;

CREATE MATERIALIZED VIEW __kafka__wizeflow_actions__mv TO actions AS SELECT * FROM __kafka__wizeflow_actions;


CREATE TABLE wizeflow.errors (
  dt DateTime,
  ms UInt32,
  rid String,
  name Nullable(String),
  code Nullable(String),
  message Nullable(String),
  stack Nullable(String),
  parameters Nullable(String)
)
ENGINE = MergeTree() 
PARTITION BY toDate(dt)
ORDER BY (dt, ms, rid) 
SETTINGS index_granularity = 8192;

CREATE TABLE __kafka__wizeflow_errors AS errors ENGINE = Kafka()
SETTINGS 
kafka_broker_list='kafka-service:19092',
kafka_topic_list = 'wizeflow.errors',
kafka_group_name = 'ch.wizeflow.errors',
kafka_format = 'JSONEachRow',
kafka_skip_broken_messages = 1;

CREATE MATERIALIZED VIEW __kafka__wizeflow_errors__mv TO errors AS SELECT * FROM __kafka__wizeflow_errors;


DROP TABLE wizeflow.tracks_view_by_smartlink_id_dt;

SET max_partitions_per_insert_block=1000;

CREATE MATERIALIZED VIEW wizeflow.tracks_view_by_smartlink_id_dt
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(smartlink_id,'00'),2) 
ORDER BY (smartlink_id, date, visitor)
POPULATE
AS 
select ifNull(smartlink_id,'0000') smartlink_id,
toDate(dt) date,
countIfState(object='sl' and event='open') views,
sumIfState(toInt32OrZero(data), object='page' and event='view') view_seconds,
countIfState(object='sl' and event='open' and os_name IN ('android', 'ios', 'Android', 'iOS')) mobile_view,
countIfState(object='sl' and event='open' and os_name not IN ('android', 'ios', 'Android', 'iOS')) desktop_view,
uniqExactIfState(fp, object='sl' and event='open') devices,
ifNull(visitor,'') visitor
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and ((object='page' and event='view') or (object='sl' and event='open'))
group by smartlink_id, toDate(dt), visitor;


DROP TABLE wizeflow.tracks_view_by_smartlink_id_page_dt;

SET max_partitions_per_insert_block=1000;

CREATE MATERIALIZED VIEW wizeflow.tracks_view_by_smartlink_id_page_dt
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(smartlink_id,'00'),2) 
ORDER BY (smartlink_id, date, ifNull(page,0), visitor)
POPULATE
AS 
select ifNull(smartlink_id,'0000') smartlink_id,
toDate(dt) date,
countIfState(event='open') page_views,
sumIfState(toInt32OrZero(data), event='view') page_view_seconds,
page,
ifNull(visitor,'') visitor
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and object='page' and event in ('view','open')
group by smartlink_id, toDate(dt), page, visitor;


DROP TABLE wizeflow.tracks_view_by_organization_id_dt;

SET max_partitions_per_insert_block=1000;

CREATE MATERIALIZED VIEW wizeflow.tracks_view_by_organization_id_dt
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(organization_id,'00'),2) 
ORDER BY (organization_id, date, visitor)
POPULATE
AS 
select ifNull(organization_id,'0000') organization_id,
toDate(dt) date,
ifNull(visitor,'') visitor,
countIfState(object='sl' and event='open') views,
sumIfState(toInt32OrZero(data), object='page' and event='view') view_seconds,
uniqExactIfState(fp, object='sl' and event='open') devices
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and ((object='page' and event='view') or (object='sl' and event='open'))
group by organization_id, toDate(dt), visitor;


DROP TABLE wizeflow.tracks_view_by_organization_id_smarlink_id_dt;

SET max_partitions_per_insert_block=1000;

CREATE MATERIALIZED VIEW wizeflow.tracks_view_by_organization_id_smarlink_id_dt
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(organization_id,'00'),2) 
ORDER BY (organization_id, user_id, smartlink_id, date, visitor)
POPULATE
AS 
select 
ifNull(organization_id,'0000') organization_id,
ifNull(user_id,'0000') user_id,
ifNull(smartlink_id,'0000') smartlink_id,
toDate(dt) date,
ifNull(visitor,'') visitor,
countState() views
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and object='sl' and event='open'
group by organization_id, user_id, smartlink_id, toDate(dt), visitor;


DROP TABLE wizeflow.tracks_views_by_smartlink_and_user_data;

SET max_partitions_per_insert_block=1000;

CREATE MATERIALIZED VIEW wizeflow.tracks_views_by_smartlink_and_user_data
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(smartlink_id,'00'),2) 
ORDER BY (ifNull(smartlink_id,'0000'), ifNull(visitor,''), ifNull(email,''), ifNull(fp,''))
POPULATE
AS 
select ifNull(smartlink_id,'0000') smartlink_id,
countState() views,
ifNull(visitor,'') visitor,
ifNull(email,'') email,
ifNull(fp,'') fp
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and object='sl' and event='open'
group by smartlink_id, visitor, email, fp


DROP TABLE IF EXISTS wizeflow.tracks_view_by__organization_id__user_id__smarlink_id__visitor;

SET max_partitions_per_insert_block=1000;

CREATE MATERIALIZED VIEW wizeflow.tracks_view_by__organization_id__user_id__smarlink_id__visitor
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(organization_id,'00'),2) 
ORDER BY (organization_id, user_id, smartlink_id, visitor)
POPULATE
AS 
select 
ifNull(organization_id,'0000') organization_id,
ifNull(user_id,'0000') user_id,
ifNull(smartlink_id,'0000') smartlink_id,
ifNull(visitor,'') visitor
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and object='sl' and event='open'
group by organization_id, user_id, smartlink_id, visitor;


CREATE DICTIONARY dict_smartlinks
(
    _id String IS_OBJECT_ID,
    title String
)
PRIMARY KEY _id
SOURCE(MONGODB(
    host 'mongo-service'
    port 27017
    user ''
    password ''
    db 'creator'
    collection 'documents'
))
LIFETIME(MIN 60 MAX 60)
LAYOUT(COMPLEX_KEY_HASHED());
```