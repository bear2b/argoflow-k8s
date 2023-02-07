USE wizeflow;

SET max_partitions_per_insert_block=1000;

CREATE MATERIALIZED VIEW wizeflow.tracks_view_by_smartlink_id__detail
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(smartlink_id,'00'),2) 
ORDER BY (smartlink_id, date, fp)
POPULATE
AS 
select ifNull(smartlink_id,'0000') smartlink_id,
toDate(dt) date,
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
uniqExact(page, object='page' and event='open') pages_viewed,
countIfState(object='page' and event='open') page_views,
sumIfState(toInt32OrZero(data), object='page' and event='view') view_seconds
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and ((object='page' and event in ('view','open')) or (object='sl' and event in ('open','download_document','print')))
group by smartlink_id, toDate(dt), fp;


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
toDate(dt) date,
countIfState(object='asset' and event='click') clicked,
countIfState(object='asset' and event='in') hovered
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and object='asset' and event in ('click','in') and asset_id != '' and page > 0
group by smartlink_id, visitor, page, asset_id, toDate(dt);