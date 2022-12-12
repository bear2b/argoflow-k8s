USE wizeflow;

DROP TABLE IF EXISTS wizeflow.tracks_view_by_smartlink_id_dt;

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


DROP TABLE IF EXISTS wizeflow.tracks_view_by_smartlink_id_page_dt;

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


DROP TABLE IF EXISTS wizeflow.tracks_view_by_organization_id_dt;

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


DROP TABLE IF EXISTS wizeflow.tracks_view_by_organization_id_smarlink_id_dt;

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


DROP TABLE IF EXISTS wizeflow.tracks_views_by_smartlink_and_user_data;

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
