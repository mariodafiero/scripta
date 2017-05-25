    update customer_data
    set  
          client_first_name = REGEXP_SUBSTR(client_full_name, '[^ ]+', 1, 1) 
        , client_mid_name   = DECODE(instr(client_full_name, ' ',1, 2), 0, NULL,
                              REGEXP_SUBSTR(client_full_name, '[^ ]+', 1, 2)) 
        , client_last_name  = DECODE(instr(client_full_name, ' ',1, 2), 0,
                              REGEXP_SUBSTR(client_full_name, '[^ ]+', 1, 2),
                              substr(client_full_name, 
                              instr(client_full_name, ' ', 1,2)+1)  )
    where customer_id = 99999 ;
    commit;
