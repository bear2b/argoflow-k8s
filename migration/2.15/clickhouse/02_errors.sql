USE wizeflow;

CREATE TABLE wizeflow.errors (
  dt DateTime,
  ms UInt32,
  rid String,
  name Nullable(String),
  code Nullable(String),
  message Nullable(String),
  stack Nullable(String),
  parameters Nullable(String)
)
ENGINE = MergeTree() 
PARTITION BY toDate(dt)
ORDER BY (dt, ms, rid) 
SETTINGS index_granularity = 8192;

CREATE TABLE __kafka__wizeflow_errors AS errors ENGINE = Kafka()
SETTINGS 
kafka_broker_list='kafka-service:19092',
kafka_topic_list = 'wizeflow.errors',
kafka_group_name = 'ch.wizeflow.errors',
kafka_format = 'JSONEachRow',
kafka_skip_broken_messages = 1;

CREATE MATERIALIZED VIEW __kafka__wizeflow_errors__mv TO errors AS SELECT * FROM __kafka__wizeflow_errors;