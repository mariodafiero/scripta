
DECLARE

    v_Response_OK varchar2(4000) := '{"commercialProcess":{"commercialOperation":{"resultCode":"00","voucher":[{"resultCode":0,"codeMsg":"","voucherNumber":12250458,"make":"Chevrolet","model":"Cruze","vin":"1G1PL5SCXC7192798","year":2012}]}}}' ;
    v_Response varchar2(4000) := '{"commercialProcess":{"commercialOperation":{"resultCode":98,"voucher":[{"resultCode":98,"codeMsg":"VEHICLE VIN IS REQUIRED","voucherNumber":-1,"make":"Chevrolet","model":"Monte Carlo","vin":"","year":2002}]}}}';
    v_base_txt  varchar2(4000);
    v_base_resp varchar2(4000);
    v_resp_rc varchar2(4000);
    v_resp_cm varchar2(4000);
    v_resp_vi varchar2(4000);

begin
    v_base_txt := substr(v_Response,instr( v_Response, '{' ,1,4 )+1 );
    v_base_resp := substr(v_base_txt,1,instr( v_base_txt,'"',1,10)) ;
    dbms_output.put_line('v_base_resp=>'|| v_base_resp || '<');
    v_resp_rc := substr(v_base_resp,instr(v_base_resp,'"resultCode":',1)+length('"resultCode":'));
    v_resp_rc := substr(v_resp_rc,1,instr(v_resp_rc,',',1,1)-1);
    dbms_output.put_line('v_resp_rc := =>'|| v_resp_rc  || '<');
    v_resp_cm := substr(v_base_resp,instr(v_base_resp,'"codeMsg":"',1)+length('"codeMsg":"'));
    v_resp_cm := substr(v_resp_cm,1,instr(v_resp_cm,',',1,1)-2);
    dbms_output.put_line('v_resp_cm := =>'|| v_resp_cm  || '<');
    v_resp_vi := substr(v_base_resp,instr(v_base_resp,'"voucherNumber":',1)+length('"voucherNumber":'));
    v_resp_vi := substr(v_resp_vi,1,instr(v_resp_vi,',',1,1)-1);
    dbms_output.put_line('v_resp_vi := =>'|| v_resp_vi  || '<');
  
END;
/
