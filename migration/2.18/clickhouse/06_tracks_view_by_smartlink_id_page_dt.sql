DROP TABLE wizeflow.tracks_view_by_smartlink_id_page_dt;

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