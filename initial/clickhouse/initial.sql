/*
use wizeflow;
drop table __kafka__wizeflow_tracks__mv;
drop table __kafka__wizeflow_tracks;
drop table tracks;
*/

CREATE DATABASE wizeflow;
use wizeflow;


CREATE TABLE wizeflow.tracks (
    dt DateTime,
    ms UInt32,
    timezone Nullable(Int16),
    session_id Nullable(String),
    smartlink_id Nullable(String),
    document_id Nullable(String),
    organization_id Nullable(String),
    user_id Nullable(String),
    batch_id Nullable(String),
    project_id Nullable(String),
    project_type Nullable(String),
    visitor Nullable(String),
    email Nullable(String),
    fp Nullable(String),
    object Nullable(String),
    type Nullable(String),
    event Nullable(String),
    data Nullable(String),
    page Nullable(UInt32),
    asset_id Nullable(String),
    browser_major Nullable(String),
    browser_name Nullable(String),
    browser_version Nullable(String),
    cpu_architecture Nullable(String),
    device_model Nullable(String),
    device_type Nullable(String),
    device_vendor Nullable(String),
    engine_name Nullable(String),
    engine_version Nullable(String),
    ip Nullable(String),
    lat Nullable(Float32),
    lon Nullable(Float32),
    online Nullable(UInt8),
    os_name Nullable(String),
    os_version Nullable(String),
    ua Nullable(String),
    old_stats_id Nullable(String)
)
ENGINE = MergeTree() 
PARTITION BY toDate(dt)
ORDER BY (dt, ms) 
SETTINGS index_granularity = 8192;


CREATE TABLE __kafka__wizeflow_tracks AS tracks ENGINE = Kafka()
SETTINGS 
kafka_broker_list='kafka-service:19092',
kafka_topic_list = 'wizeflow.tracks',
kafka_group_name = 'ch.wizeflow.tracks',
kafka_format = 'JSONEachRow',
kafka_skip_broken_messages = 1;

CREATE MATERIALIZED VIEW __kafka__wizeflow_tracks__mv TO tracks AS SELECT * FROM __kafka__wizeflow_tracks;

-- To avoid problem: Too many partitions for single INSERT block (more than 100).
-- SET max_partitions_per_insert_block=1000


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
group by smartlink_id, visitor, email, fp;


SET max_partitions_per_insert_block=1000;
CREATE MATERIALIZED VIEW wizeflow.tracks_view_by_organization_id_dt
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(organization_id,'00'),2) 
ORDER BY (organization_id, date, visitor, folder_id)
POPULATE
AS 
select ifNull(organization_id,'0000') organization_id,
toDate(date_add(minute,-ifNull(timezone,0),dt)) date,
ifNull(visitor,'') visitor,
countIfState(object='sl' and event='open') views,
sumIfState(toInt32OrZero(data), object='page' and event='view') view_seconds,
uniqExactIfState(fp, object='sl' and event='open') devices,
countIfState(object='sl' and event='download_document') downloaded,
countIfState(object='sl' and event='print') printed,
ifNull(dictGet('dict_smartlinks', '_folder', smartlink_id), '') folder_id
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and ((object='page' and event='view') or (object='sl' and event in ('open', 'download_document', 'print')))
group by organization_id, date, visitor, folder_id;



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
toDate(date_add(minute,-ifNull(timezone,0),dt)) date,
ifNull(visitor,'') visitor,
countState() views
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and object='sl' and event='open'
group by organization_id, user_id, smartlink_id, date, visitor;


SET max_partitions_per_insert_block=1000;
CREATE MATERIALIZED VIEW wizeflow.tracks_view_by_smartlink_id_dt
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(smartlink_id,'00'),2) 
ORDER BY (smartlink_id, date, visitor)
POPULATE
AS 
select ifNull(smartlink_id,'0000') smartlink_id,
toDate(date_add(minute,-ifNull(timezone,0),dt)) date,
countIfState(object='sl' and event='open') views,
sumIfState(toInt32OrZero(data), object='page' and event='view') view_seconds,
countIfState(object='sl' and event='open' and os_name IN ('android', 'ios', 'Android', 'iOS')) mobile_view,
countIfState(object='sl' and event='open' and os_name not IN ('android', 'ios', 'Android', 'iOS')) desktop_view,
uniqExactIfState(fp, object='sl' and event='open') devices,
countIfState(object='sl' and event='download_document') downloaded,
countIfState(object='sl' and event='print') printed,
ifNull(visitor,'') visitor
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and ((object='page' and event='view') or (object='sl' and event in ('open', 'download_document', 'print')))
group by smartlink_id, date, visitor;


SET max_partitions_per_insert_block=1000;
CREATE MATERIALIZED VIEW wizeflow.tracks_view_by_smartlink_id_page_dt
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(smartlink_id,'00'),2) 
ORDER BY (smartlink_id, date, ifNull(page,0), visitor)
POPULATE
AS 
select ifNull(smartlink_id,'0000') smartlink_id,
toDate(date_add(minute,-ifNull(timezone,0),dt)) date,
countIfState(event='open') page_views,
sumIfState(toInt32OrZero(data), event='view') page_view_seconds,
page,
ifNull(visitor,'') visitor
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and object='page' and event in ('view','open')
group by smartlink_id, date, page, visitor;


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


SET max_partitions_per_insert_block=1000;
CREATE MATERIALIZED VIEW wizeflow.tracks_view_by_smartlink_id__detail
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(smartlink_id,'00'),2) 
ORDER BY (smartlink_id, date, fp)
POPULATE
AS 
select ifNull(smartlink_id,'0000') smartlink_id,
toDate(date_add(minute,-ifNull(timezone,0),dt)) date,
ifNull(fp, '') fp,
substr( max(concat(toString(dt),visitor)), 20) visitor_name,
any(email) email,
if(
  email = '',
  if(visitor_name = 'none', '', visitor_name),
  if(visitor_name = 'none', email, concat(email, ' (send by ', visitor_name, ')'))
) last_user,
min(dt) first_visit, 
max(dt) last_visit, 
any(ua) ua, 
any(os_name) os_name, 
any(os_version) os_version, 
any(browser_major) browser_major, 
any(browser_name) browser_name, 
any(browser_version) browser_version,
any(engine_name) engine_name,
any(engine_version) engine_version,
countIfState(object='sl' and event='open') views,
countIfState(object='sl' and event='download_document') downloaded,
countIfState(object='sl' and event='print') printed,
uniqExactIfState(concat(smartlink_id,toString(page)), object='page' and event='open') pages_viewed,
countIfState(object='page' and event='open') page_views,
sumIfState(toInt32OrZero(data), object='page' and event='view') view_seconds
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and ((object='page' and event in ('view','open')) or (object='sl' and event in ('open','download_document','print')))
group by smartlink_id, date, fp;


SET max_partitions_per_insert_block=1000;
CREATE MATERIALIZED VIEW wizeflow.tracks_view_by_smartlink_id__assets
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(smartlink_id,'00'),2) 
ORDER BY (smartlink_id, visitor, page, asset_id, date)
POPULATE
AS 
select ifNull(smartlink_id,'0000') smartlink_id,
ifNull(visitor, '') visitor,
ifNull(asset_id,'') asset_id,
ifNull(page,0) page,
toDate(date_add(minute,-ifNull(timezone,0),dt)) date,
countIfState(object='asset' and event='click') clicked,
countIfState(object='asset' and event='in') hovered
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and object='asset' and event in ('click','in') and asset_id != '' and page > 0
group by smartlink_id, visitor, page, asset_id, date;


CREATE DICTIONARY wizeflow.dict_smartlinks (`_id` String IS_OBJECT_ID, `title` String) 
PRIMARY KEY _id 
SOURCE(MONGODB(HOST 'mongo-service' PORT 27017 USER '' PASSWORD '' DB 'creator' COLLECTION 'documents' OPTIONS 'connectTimeoutMS=10000')) 
LIFETIME(MIN 60 MAX 60) 
LAYOUT(COMPLEX_KEY_HASHED());