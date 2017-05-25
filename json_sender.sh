#!/bin/bash
dir_base=/home/mdafiero/BATCHTOOL
dir_input="$dir_base/input"
dir_config="$dir_base/config"
dir_log="$dir_base/log"

source $dir_config/config.sh

inF=dw_json.txt
maxR=$( wc -l $inF  | awk -F" " '{ print $1 }' )

##id_batch=$( awk -F";" '{print $1;}' $inF )

## maxR=1

rm -f dw_json.respo
for ((r=1; r<=$maxR; r++))
do
    rm -f temp.json
    echo "Welcome $r times"

    inR=request.tmp
    
    head -n $r $inF | tail -1 > $inR
    id_batch=$( awk -F";" '{ print $1 } ' $inR )
    json_req=$( awk -F";" '{ print $2 } ' $inR )
    
    echo "ID_BATCH = $id_batch"
    echo "JSON_REQ = >${json_req}<"
    echo ${json_req} > temp.json

    json_resp=$( curl -H "Content-Type: application/json" -X POST -d '@temp.json'  -u ${ws_user}:${ws_pass} ${ws_endpoint}  )
    
    sqlplus -s ${DB_USER}/${DB_PASSWORD}@${DB_SID}  <<EOF
DECLARE
   I_BATCHID    VARCHAR2 (32767);
   I_RESPONSE   VARCHAR2 (32767);
BEGIN
   I_BATCHID := ${id_batch} ;
   I_RESPONSE := '$json_resp' ;

   INSERT_JSON_RESPONSE (I_BATCHID, I_RESPONSE);

   COMMIT;
END;
/
EOF

    echo "JSON_RESP = >$json_resp<"
    echo "${id_batch};${json_req};${json_resp}" >> dw_json.respo

done

