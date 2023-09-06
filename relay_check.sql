spool /ORA/script/relay_check.log

set linesize 6000
set feedback off
set echo off
set trimout off
set trimspool off
set termout off
set verify off
set HEA off
set pagesize 0
set trimspool on
set head off
set headsep off
set newp none
set linesize 32767
set pagesize 50000
set sqlblanklines OFF
set trimspool ON
set termout off
set feedback off

SELECT '投注RELAY_BET->錯誤筆數' || COUNT(1)
FROM lg.RELAY_BET a,
    lg.auth_account b
WHERE a.clearing_Date >= SYSDATE - 3
    AND A.ACCOUNT_ID = b.id
    AND a.ACCOUNT_PATH != B.ACCOUNT_ID_PATH
HAVING COUNT(1) > 0
UNION ALL
SELECT '天能RELAY_TNBET->錯誤筆數' || COUNT(1)
  FROM lg.RELAY_TNBET a, lg.auth_account b
 WHERE     a.clearing_date >= SYSDATE - 3
       AND A.ACCOUNT_ID = b.id
       AND a.account_path != B.ACCOUNT_ID_PATH
HAVING COUNT(1) > 0
UNION ALL
SELECT '返點RELAY_REBATE->錯誤筆數' || COUNT(1)
  FROM lg.RELAY_REBATE a, lg.auth_account b
 WHERE     a.flow_record_date >= SYSDATE - 3
       AND A.ACCOUNT_ID = b.id
       AND a.account_path != B.ACCOUNT_ID_PATH
HAVING COUNT(1) > 0
UNION ALL
SELECT '充值RELAY_RECHARGE->錯誤筆數' || COUNT(1)
  FROM lg.RELAY_RECHARGE a, lg.auth_account b
 WHERE     a.DEPOSIT_DATE >= SYSDATE - 3
       AND A.ACCOUNT_ID = b.id
       AND a.ACCOUNT_PATH != B.ACCOUNT_ID_PATH
HAVING COUNT(1) > 0
UNION ALL
SELECT '其他RELAY_OTHER->錯誤筆數' || COUNT(1)
  FROM lg.RELAY_OTHER a, lg.auth_account b
 WHERE     a.FLOW_RECORD_DATE >= SYSDATE - 3
       AND A.ACCOUNT_ID = b.id
       AND a.ACCOUNT_PATH != B.ACCOUNT_ID_PATH
HAVING COUNT(1) > 0
UNION ALL
SELECT '對戰RELAY_BET_BATTLE->錯誤筆數' || COUNT(1)
  FROM lg.RELAY_BET_BATTLE a, lg.auth_account b
 WHERE     a.CREATE_DATE >= SYSDATE - 3
       AND A.ACCOUNT_ID = b.id
       AND a.ACCOUNT_ID_PATH != B.ACCOUNT_ID_PATH
HAVING COUNT(1) > 0
UNION ALL
SELECT '活動RELAY_ACTIVITY->錯誤筆數' || COUNT(1)
  FROM lg.RELAY_ACTIVITY a, lg.auth_account b
 WHERE     a.flow_record_date >= SYSDATE - 3
       AND A.ACCOUNT_ID = b.id
       AND a.account_path != B.ACCOUNT_ID_PATH
HAVING COUNT(1) > 0
UNION ALL
---- 未結的PATH 跟現在的PATH 不同的數據
SELECT '未結-BET_NOCLEARING_ALL->錯誤筆數' || COUNT(1)
  FROM lg.BET_NOCLEARING_ALL a, lg.auth_account b
 WHERE     a.create_Date >= SYSDATE - 1
       AND A.ACCOUNT_ID = b.id
       AND a.account_path != B.ACCOUNT_ID_PATH
       and a.status = 1
HAVING COUNT(1) > 0;


spool off

exit;
