select batch_id || ';' || 
 regexp_replace( replace(replace(to_char(request_json),chr(13),null),chr(10), null) ,'[[:space:]]+', chr(32))  as csv_data
from json_table_name
where out_result is null 
and request_json is not null
