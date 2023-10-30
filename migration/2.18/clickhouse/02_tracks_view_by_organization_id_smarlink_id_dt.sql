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
toDate(date_add(minute,-ifNull(timezone,0),dt)) date,
ifNull(visitor,'') visitor,
countState() views
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and object='sl' and event='open'
group by organization_id, user_id, smartlink_id, date, visitor;