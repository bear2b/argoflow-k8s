DROP TABLE IF EXISTS wizeflow.tracks_view_by_smartlink_id__detail;

SET max_partitions_per_insert_block=1000, max_memory_usage=4000000000, max_memory_usage_for_user=4000000000;
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
min(date_add(minute,-ifNull(timezone,0),dt)) first_visit, 
max(date_add(minute,-ifNull(timezone,0),dt)) last_visit, 
any(ua) ua, 
any(timezone) tz,
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