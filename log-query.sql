SELECT 
hostname,
type,
query_id, 
query_start_time,
query_duration_ms,
query,
query_kind,
current_database,
columns,
tables,
user,
result_rows,
result_bytes,
memory_usage,
address,
port,
http_method,
http_user_agent,
http_referer

FROM system.query_log 
where  
  query NOT LIKE '%system.%'
  AND query NOT LIKE '%select default.timezone()%'
  AND hasAny(databases, ['system']) = 0
  AND hasAny(tables, ['system.one']) = 0
order by event_date desc 
Limit 20


SELECT
    type,
    event_time AS Time_Date,
    query_id AS Query_ID,
    query,
    query_kind,
    current_database,
    columns,
    tables,
    user,
    formatReadableSize(memory_usage) AS Memory,
    `ProfileEvents.Values`[indexOf(`ProfileEvents.Names`, 'UserTimeMicroseconds')] /1000000 AS userCPU,
    `ProfileEvents.Values`[indexOf(`ProfileEvents.Names`, 'SystemTimeMicroseconds')] /1000000 AS systemCPU
FROM system.query_log
ORDER BY memory_usage DESC
LIMIT 20;








