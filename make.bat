echo

call rails destroy scaffold message
call rails destroy scaffold name_mst
call rails destroy scaffold member_mst
call rails destroy scaffold gift_master

call rails g scaffold message msg_code:string  message:text   upd_uid:string  
call rails g scaffold name_mst code_id:string  code_id_name:string  code:string  name:text   
call rails g scaffold member_mst menber_no:string menber_name:string admission_date:date withdrawal_date:date birth_date:date enter_date:date marry_date:date memo:string del_flg:string
call rails g scaffold gift_master div:string condition:string condition_year:integer amount:string year_flg:string

pause:

