DROP TABLE IF EXISTS wizeflow.tracks_view_by_smartlink_id_dt;
SET max_partitions_per_insert_block=1000;

CREATE MATERIALIZED VIEW IF NOT EXISTS wizeflow.tracks_view_by_smartlink_id_dt
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