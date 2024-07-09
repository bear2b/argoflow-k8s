USE wizeflow;

ALTER TABLE wizeflow.tracks ADD COLUMN asset_original_filename Nullable(String);

DROP TABLE IF EXISTS __kafka__wizeflow_tracks__mv;
DROP TABLE IF EXISTS __kafka__wizeflow_tracks;

CREATE TABLE IF NOT EXISTS __kafka__wizeflow_tracks AS tracks ENGINE = Kafka()
SETTINGS 
kafka_broker_list='kafka1:19092',
kafka_topic_list = 'wizeflow.tracks',
kafka_group_name = 'ch.wizeflow.tracks',
kafka_format = 'JSONEachRow',
kafka_skip_broken_messages = 1;

CREATE MATERIALIZED VIEW IF NOT EXISTS __kafka__wizeflow_tracks__mv TO tracks AS SELECT * FROM __kafka__wizeflow_tracks;