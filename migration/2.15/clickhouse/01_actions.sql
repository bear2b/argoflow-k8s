USE wizeflow;

CREATE TABLE wizeflow.actions (
  dt DateTime,
  ms UInt32,
  rid String,
  ua Nullable(String),
  url Nullable(String),
  method Nullable(String),
  entity Nullable(String),
  entity_id Nullable(String),
  user_id Nullable(String),
  user_name Nullable(String),
  organization_id Nullable(String)
)
ENGINE = MergeTree() 
PARTITION BY toDate(dt)
ORDER BY (dt, ms, rid) 
SETTINGS index_granularity = 8192;

CREATE TABLE __kafka__wizeflow_actions AS actions ENGINE = Kafka()
SETTINGS 
kafka_broker_list='kafka-service:19092',
kafka_topic_list = 'wizeflow.actions',
kafka_group_name = 'ch.wizeflow.actions',
kafka_format = 'JSONEachRow',
kafka_skip_broken_messages = 1;

CREATE MATERIALIZED VIEW __kafka__wizeflow_actions__mv TO actions AS SELECT * FROM __kafka__wizeflow_actions;