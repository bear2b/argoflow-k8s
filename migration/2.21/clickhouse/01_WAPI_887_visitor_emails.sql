use wizeflow;

DROP TABLE IF EXISTS wizeflow.tracks_view_by__organization_id__user_id__smarlink_id__visitor_emails;

SET max_partitions_per_insert_block=1000;
CREATE MATERIALIZED VIEW IF NOT EXISTS wizeflow.tracks_view_by__organization_id__user_id__smarlink_id__visitor_emails
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(organization_id,'00'),2) 
ORDER BY (organization_id, user_id, smartlink_id, email)
POPULATE
AS 
select 
ifNull(organization_id,'0000') organization_id,
ifNull(user_id,'0000') user_id,
ifNull(smartlink_id,'0000') smartlink_id,
ifNull(email,'') email
from wizeflow.tracks
where email != '' and fp!='' and visitor!='anonymous' and object='sl' and event='open'
group by organization_id, user_id, smartlink_id, email;


DROP TABLE IF EXISTS wizeflow.tracks_view_by_smartlink_id__detail;

SET max_partitions_per_insert_block=1000, max_memory_usage = 4000000000, max_memory_usage_for_user = 4000000000;
CREATE MATERIALIZED VIEW IF NOT EXISTS wizeflow.tracks_view_by_smartlink_id__detail
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(smartlink_id,'00'),2) 
ORDER BY (smartlink_id, date, fp)
POPULATE
AS 
select ifNull(smartlink_id,'0000') smartlink_id,
toDate(date_add(minute,-ifNull(timezone,0),dt)) date,
ifNull(fp, '') fp,
substr( max(concat(toString(dt),visitor)), 20) visitor_name,
substr( max(concat(toString(dt),email)), 20) visitor_email,
if(
  visitor_email = '',
  if(visitor_name = 'none', '', visitor_name),
  if(visitor_name = 'none', visitor_email, concat(visitor_email, ' (send by ', visitor_name, ')'))
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


DROP TABLE IF EXISTS wizeflow.tracks_view_by_smartlink_id__assets;

SET max_partitions_per_insert_block=1000;
CREATE MATERIALIZED VIEW IF NOT EXISTS wizeflow.tracks_view_by_smartlink_id__assets
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(smartlink_id,'00'),2) 
ORDER BY (smartlink_id, visitor, email, page, asset_id, date)
POPULATE
AS 
select ifNull(smartlink_id,'0000') smartlink_id,
ifNull(visitor, '') visitor,
ifNull(email, '') email,
ifNull(asset_id,'') asset_id,
ifNull(page,0) page,
toDate(date_add(minute,-ifNull(timezone,0),dt)) date,
countIfState(object='asset' and event='click') clicked,
countIfState(object='asset' and event='in') hovered
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and object='asset' and event in ('click','in') and asset_id != '' and page > 0
group by smartlink_id, visitor, email, page, asset_id, date;


DROP TABLE IF EXISTS wizeflow.tracks_view_by_smartlink_id_dt;

SET max_partitions_per_insert_block=1000;
CREATE MATERIALIZED VIEW IF NOT EXISTS wizeflow.tracks_view_by_smartlink_id_dt
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(smartlink_id,'00'),2) 
ORDER BY (smartlink_id, date, visitor, email)
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
ifNull(visitor,'') visitor,
ifNull(email,'') email
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and ((object='page' and event='view') or (object='sl' and event in ('open', 'download_document', 'print')))
group by smartlink_id, date, visitor, email;


DROP TABLE IF EXISTS wizeflow.tracks_view_by_smartlink_id_page_dt;

SET max_partitions_per_insert_block=1000;
CREATE MATERIALIZED VIEW IF NOT EXISTS wizeflow.tracks_view_by_smartlink_id_page_dt
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(smartlink_id,'00'),2) 
ORDER BY (smartlink_id, date, ifNull(page,0), visitor, email)
POPULATE
AS 
select ifNull(smartlink_id,'0000') smartlink_id,
toDate(date_add(minute,-ifNull(timezone,0),dt)) date,
countIfState(event='open') page_views,
sumIfState(toInt32OrZero(data), event='view') page_view_seconds,
page,
ifNull(visitor,'') visitor,
ifNull(email,'') email
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and object='page' and event in ('view','open')
group by smartlink_id, date, page, visitor, email;


DROP TABLE IF EXISTS wizeflow.tracks_view_by_organization_id_dt;

SET max_partitions_per_insert_block=1000;
CREATE MATERIALIZED VIEW IF NOT EXISTS wizeflow.tracks_view_by_organization_id_dt
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(organization_id,'00'),2) 
ORDER BY (organization_id, date, visitor, email, folder_id)
POPULATE
AS 
select ifNull(organization_id,'0000') organization_id,
toDate(date_add(minute,-ifNull(timezone,0),dt)) date,
ifNull(visitor,'') visitor,
ifNull(email,'') email,
countIfState(object='sl' and event='open') views,
sumIfState(toInt32OrZero(data), object='page' and event='view') view_seconds,
uniqExactIfState(fp, object='sl' and event='open') devices,
countIfState(object='sl' and event='download_document') downloaded,
countIfState(object='sl' and event='print') printed,
ifNull(dictGet('dict_smartlinks', '_folder', smartlink_id), '') folder_id
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and ((object='page' and event='view') or (object='sl' and event in ('open', 'download_document', 'print')))
group by organization_id, date, visitor, email, folder_id;


DROP TABLE IF EXISTS wizeflow.tracks_view_by_organization_id_smarlink_id_dt;

SET max_partitions_per_insert_block=1000;
CREATE MATERIALIZED VIEW IF NOT EXISTS wizeflow.tracks_view_by_organization_id_smarlink_id_dt
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(organization_id,'00'),2) 
ORDER BY (organization_id, user_id, smartlink_id, date, visitor, email)
POPULATE
AS 
select 
ifNull(organization_id,'0000') organization_id,
ifNull(user_id,'0000') user_id,
ifNull(smartlink_id,'0000') smartlink_id,
toDate(date_add(minute,-ifNull(timezone,0),dt)) date,
ifNull(visitor,'') visitor,
ifNull(email,'') email,
countState() views
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and object='sl' and event='open'
group by organization_id, user_id, smartlink_id, date, visitor, email;