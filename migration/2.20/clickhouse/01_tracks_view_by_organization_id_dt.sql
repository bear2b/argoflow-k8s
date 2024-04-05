USE wizeflow;

SET max_partitions_per_insert_block=1000;

DROP TABLE IF EXISTS wizeflow.tracks_view_by_organization_id_dt;

CREATE MATERIALIZED VIEW IF NOT EXISTS wizeflow.tracks_view_by_organization_id_dt
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
