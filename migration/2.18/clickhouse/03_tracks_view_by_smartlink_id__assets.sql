DROP TABLE wizeflow.tracks_view_by_smartlink_id__assets;

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