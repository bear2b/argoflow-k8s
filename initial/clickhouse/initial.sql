/*
use wizeflow;
drop table __kafka__wizeflow_tracks__mv;
drop table __kafka__wizeflow_tracks;
drop table tracks;
*/

CREATE DATABASE IF NOT EXISTS wizeflow;
use wizeflow;

CREATE TABLE wizeflow.tracks (
    dt DateTime,
    ms UInt32,
    timezone Nullable(Int16),
    session_id Nullable(String), 
    document_id Nullable(String), 
    document_uuid Nullable(String),
    content_id Nullable(String),
    organization_id Nullable(String),
    project_id Nullable(String),
    member_id Nullable(String),
    user Nullable(String),
    email Nullable(String),
    fp Nullable(String),
    action Nullable(String),
    duration Nullable(UInt32),
    page Nullable(UInt32),
    page_id Nullable(UInt32),
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

SET max_partitions_per_insert_block=1000;
CREATE MATERIALIZED VIEW wizeflow.tracks_page_views_by_document
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(document_uuid,'00'),2) 
ORDER BY ifNull(document_uuid,'0000')
POPULATE
AS 
select ifNull(document_uuid,'0000') document_uuid, countIfState(action='ENTER') views, 
sumState(duration) view_seconds, 
uniqExactIfState(fp,action='PAGE_VIEW') devices
from wizeflow.tracks
where fp!='' and user!='anonymous'
group by document_uuid;


SET max_partitions_per_insert_block=1000;
CREATE MATERIALIZED VIEW wizeflow.tracks_page_views_by_date
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(document_uuid,'00'),2) 
ORDER BY (document_uuid,date,user,page)
POPULATE
AS 
select ifNull(document_uuid,'0000') document_uuid, 
toDate(dt) date, 
ifNull(user,'') user,
ifNull(page,0) page, 
countIfState(action='OPEN') views,
maxIfState(dt,action='PAGE_VIEW') last_viewed, 
sumState(duration) view_seconds, 
uniqExactIfState(fp,action='PAGE_VIEW') devices
from wizeflow.tracks
where action in ('PAGE_VIEW','OPEN') and page>0 and fp!='' and user!='anonymous'
group by document_uuid,toDate(dt),user,page
order by page;
