CREATE TABLE kafka_attributes (
  id SERIAL PRIMARY KEY,
  am_id integer unique not null,
  attributes jsonb
);
CREATE INDEX attributes_am_id on kafka_attributes (am_id);
