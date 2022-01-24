-- use wizeflow;
-- drop table __kafka__wizeflow_tracks__mv;
-- drop table __kafka__wizeflow_tracks;

-- ALTER TABLE wizeflow.tracks MODIFY COLUMN asset_id Nullable(String);

-- -- SHOW CREATE TABLE __kafka__wizeflow_tracks

-- CREATE TABLE __kafka__wizeflow_tracks AS tracks ENGINE = Kafka()
-- SETTINGS 
-- kafka_broker_list='kafka-service:19092',
-- kafka_topic_list = 'wizeflow.tracks',
-- kafka_group_name = 'ch.wizeflow.tracks',
-- kafka_format = 'JSONEachRow',
-- kafka_skip_broken_messages = 1;

-- CREATE MATERIALIZED VIEW __kafka__wizeflow_tracks__mv TO tracks AS SELECT * FROM __kafka__wizeflow_tracks;
