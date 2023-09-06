#!/bin/bash

export TMP=/tmp
export TMPDIR=$TMP
export ORACLE_SID=LG1
export NLS_LANG=AMERICAN_AMERICA.AL32UTF8
export ORACLE_HOME=/ORA/db/11.2.4
export PATH=$ORACLE_HOME/bin:$PATH

sql_file=/ORA/script/relay_check.sql
log_file=/ORA/script/relay_check.log
#建空的就好
exec_file=/ORA/script/relay_check.sh
#建空的就好

SQLPLUS=$ORACLE_HOME/bin/sqlplus
# 連線資訊
CONN_LG=LG/peagMrBydzEgerUB@LG


rm -rf  /ORA/script/relay_check.log

#### export info
$SQLPLUS $CONN_LG <<EOF 
@$sql_file

EOF

### 帶入要顯示的文字

#echo 'BOT_TOKEN='''bot5434896827:AAFBAoEWw9UnMmde1FUV75MDUNfZj8e5v0k'''' >  $exec_file
#echo 'CHAT_ID='''-608975891'''' >>  $exec_file
echo 'BOT_TOKEN='''bot314735976:AAHY2LywQI9HOFBCwJ1vVF9cKKL-ZP1lFeY'''' >  $exec_file
echo 'CHAT_ID='''-1001410002418'''' >>  $exec_file

echo 'BODY="' >>  $exec_file
sed '/^$/d' $log_file >> $exec_file
echo '"' >>  $exec_file

echo '/usr/bin/curl -X  POST --data chat_id=$CHAT_ID --data text="$BODY" https://api.telegram.org/$BOT_TOKEN/sendMessage' >>  $exec_file

### 執行點
sh $exec_file
