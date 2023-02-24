# How to run script:
# 1) Go to the ClickHouse server
# 2) Execute this file there

function checkIfMutationsAreDone {
  while true; do
    mutations=$(clickhouse-client --query="select count() from system.mutations where database='wizeflow' and table='tracks' and is_done=0")
    if [[ $mutations == 0 ]]; then   
      break
    fi
    echo "Mutations are not done. Waiting 3 seconds and check again..."
    sleep 3
  done
}

clickhouse-client --query="DROP TABLE IF EXISTS wizeflow.old_tracks_page_views_by_date"
clickhouse-client --query="DROP TABLE IF EXISTS wizeflow.old_tracks_views_by_smartlink_id"
clickhouse-client --query="DROP TABLE IF EXISTS wizeflow.old_tracks_page_views_count_by_organization"

clickhouse-client --query="DROP TABLE IF EXISTS wizeflow.tracks_view_by_member_id_dt"

clickhouse-client --query="DROP TABLE IF EXISTS wizeflow.tracks_page_views_by_date"
clickhouse-client --query="DROP TABLE IF EXISTS wizeflow.tracks_page_views_by_document"
clickhouse-client --query="DROP TABLE IF EXISTS wizeflow.tracks_page_views_count_by_organization"

clickhouse-client --query="DROP TABLE IF EXISTS wizeflow.tracks_view_by_document_id_dt"
clickhouse-client --query="DROP TABLE IF EXISTS wizeflow.tracks_view_by_document_id_page_dt"
clickhouse-client --query="DROP TABLE IF EXISTS wizeflow.tracks_view_by_organization_id_dt"
clickhouse-client --query="DROP TABLE IF EXISTS wizeflow.tracks_views_by_document_and_user_data"

checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks ADD COLUMN event Nullable(String) AFTER action"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE event=action WHERE action is not null"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks DROP COLUMN action"

checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks ADD COLUMN smartlink_id Nullable(String) AFTER document_id"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE smartlink_id=document_id WHERE document_id is not null"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks DROP COLUMN document_id"
checkIfMutationsAreDone

checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks ADD COLUMN document_id Nullable(String) AFTER content_id"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE document_id=content_id WHERE content_id is not null"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks DROP COLUMN content_id"

checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks ADD COLUMN user_id Nullable(String) AFTER member_id"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE user_id=member_id WHERE member_id is not null"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks DROP COLUMN member_id"

checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks ADD COLUMN visitor Nullable(String) AFTER user"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE visitor=user WHERE user is not null"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks DROP COLUMN user"

checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks ADD COLUMN data Nullable(UInt32) AFTER duration"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE data=duration WHERE duration is not null"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks DROP COLUMN duration"

checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks MODIFY COLUMN data Nullable(String)"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE data=null WHERE data='0'"

checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks DROP COLUMN project_id"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks DROP COLUMN page_id"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks DROP COLUMN document_uuid"

checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks ADD COLUMN object Nullable(String) AFTER fp"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks ADD COLUMN type Nullable(String) AFTER object"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks ADD COLUMN project_id Nullable(String) AFTER user_id"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks ADD COLUMN project_type Nullable(String) AFTER project_id"

checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE object='sl', event='open' WHERE event='ENTER'"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE object='sl', event='close' WHERE event='EXIT'"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE object='sl', event='geolocate' WHERE event='MOVE'"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE object='sl', event='download_document' WHERE event='DOWNLOAD'"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE object='sl', event='search' WHERE event='SEARCH'"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE object='sl', event='search_next' WHERE event='NEXT'"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE object='sl', event='print' WHERE event='PRINT'"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE object='sl', event='assets_show' WHERE event='ASSETS SHOW'"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE object='sl', event='assets_hide' WHERE event='ASSETS CLOSE'"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE object='page', event='open' WHERE event='OPEN'"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE object='page', event='view' WHERE event='PAGE_VIEW'"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE object='page', event='text_copy' WHERE event='COPY'"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE object='asset', event='in' WHERE event='AURA IN'"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE object='asset', event='out' WHERE event='AURA OUT'"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE object='asset', event='open' WHERE event='AURA CLICK'"
checkIfMutationsAreDone
clickhouse-client --query="ALTER TABLE wizeflow.tracks UPDATE object='asset', event='close' WHERE event='AURA CLOSE'"


clickhouse-client --query="SET max_partitions_per_insert_block=1000"
clickhouse-client --query="CREATE MATERIALIZED VIEW wizeflow.tracks_view_by_smartlink_id_dt
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(smartlink_id,'00'),2) 
ORDER BY (smartlink_id, date)
POPULATE
AS 
select ifNull(smartlink_id,'0000') smartlink_id,
toDate(dt) date,
countIfState(object='sl' and event='open') views,
sumIfState(toInt32OrZero(data), object='page' and event='view') view_seconds,
countIfState(object='sl' and event='open' and os_name IN ('android', 'ios', 'Android', 'iOS')) mobile_view,
countIfState(object='sl' and event='open' and os_name not IN ('android', 'ios', 'Android', 'iOS')) desktop_view,
uniqExactIfState(fp, object='sl' and event='open') devices
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and ((object='page' and event='view') or (object='sl' and event='open'))
group by smartlink_id, toDate(dt)"


clickhouse-client --query="SET max_partitions_per_insert_block=1000"
clickhouse-client --query="CREATE MATERIALIZED VIEW wizeflow.tracks_view_by_smartlink_id_page_dt
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(smartlink_id,'00'),2) 
ORDER BY (smartlink_id, date, ifNull(page,0))
POPULATE
AS 
select ifNull(smartlink_id,'0000') smartlink_id,
toDate(dt) date,
countIfState(event='open') page_views,
sumIfState(toInt32OrZero(data), event='view') page_view_seconds,
page
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and object='page' and event in ('view','open')
group by smartlink_id, toDate(dt), page"


clickhouse-client --query="SET max_partitions_per_insert_block=1000"
clickhouse-client --query="CREATE MATERIALIZED VIEW wizeflow.tracks_view_by_organization_id_dt
ENGINE = AggregatingMergeTree() 
PARTITION BY left(ifNull(organization_id,'00'),2) 
ORDER BY (organization_id, date)
POPULATE
AS 
select ifNull(organization_id,'0000') organization_id,
toDate(dt) date,
countIfState(object='sl' and event='open') views,
sumIfState(toInt32OrZero(data), object='page' and event='view') view_seconds,
uniqExactIfState(fp, object='sl' and event='open') devices
from wizeflow.tracks
where fp!='' and visitor!='anonymous' and ((object='page' and event='view') or (object='sl' and event='open'))
group by organization_id, toDate(dt)"


clickhouse-client --query="SET max_partitions_per_insert_block=1000"
clickhouse-client --query="CREATE MATERIALIZED VIEW wizeflow.tracks_views_by_smartlink_and_user_data
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
group by smartlink_id, visitor, email, fp"


clickhouse-client --query="ALTER TABLE wizeflow.tracks ADD COLUMN batch_id Nullable(String) AFTER user_id"

echo "The migration was completed successfully"