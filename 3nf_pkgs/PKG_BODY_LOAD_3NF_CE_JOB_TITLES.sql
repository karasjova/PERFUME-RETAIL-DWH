-------------------------------
CREATE OR REPLACE PACKAGE BODY PKG_LOAD_3NF_CE_JOB_TITLES AS

PROCEDURE PROC_LOAD_CE_JOB_TITLES IS
    L_PROCEDURE_NAME    VARCHAR2(2000) := 'PROC_LOAD_CE_JOB_TITLES';
    L_TABLE_NAME        VARCHAR2(2000) := 'CE_JOB_TITLES';
    L_ROWS_PROCESSED    NUMBER;
    L_CONTEXT           VARCHAR2(2000) := 'LOADING CE_JOB_TITLES';
    L_ROW_COUNT_BEFORE  NUMBER;
    L_ROW_COUNT_AFTER   NUMBER;
    TYPE t_ref_c IS REF CURSOR;
    ref_cur    t_ref_c;      
    
BEGIN

OPEN ref_cur FOR 'SELECT COUNT(*)FROM BL_3NF.CE_JOB_TITLES';

FETCH ref_cur INTO L_ROW_COUNT_BEFORE;
CLOSE ref_cur;

PROC_LOG(L_PACKAGE_NAME, L_PROCEDURE_NAME, L_TABLE_NAME, L_CONTEXT, 'PROCEDURE STARTS', L_ROW_COUNT_BEFORE, SYSDATE);

MERGE INTO BL_3NF.CE_JOB_TITLES  TARG
USING 
       (SELECT DISTINCT
            TRIM(JOB_TITLE) AS JOB_TITLE_SRCID, 
            TRIM(JOB_TITLE) AS JOB_TITLE_DESC,
            'business_entities' AS  SOURCE_SYSTEM,
            'src_business_entities' AS SOURCE_TABLE,
            SYSDATE AS INSERT_DT,
            SYSDATE AS UPDATE_DT
        FROM
            SRC_BUSINESS_ENTITIES
        UNION ALL
        SELECT DISTINCT
            TRIM(JOB_TITLE) AS JOB_TITLE_SRCID, 
            TRIM(JOB_TITLE) AS JOB_TITLE_DESC,
            'individual_customers' AS  SOURCE_SYSTEM,
            'src_individual_customers' AS SOURCE_TABLE,
            SYSDATE AS INSERT_DT,
            SYSDATE AS UPDATE_DT
        FROM
             SRC_INDIVIDUAL_CUSTOMERS) SRC
ON  (TARG.JOB_TITLE_SRCID = SRC.JOB_TITLE_SRCID
    AND TARG.SOURCE_SYSTEM = SRC.SOURCE_SYSTEM
    AND TARG.SOURCE_TABLE = SRC.SOURCE_TABLE)
WHEN MATCHED THEN UPDATE SET 
    TARG.JOB_TITLE_DESC = SRC.JOB_TITLE_DESC,
    TARG.UPDATE_DT = SYSDATE
    WHERE TARG.JOB_TITLE_DESC <> SRC.JOB_TITLE_DESC
WHEN NOT MATCHED THEN INSERT 
    (JOB_TITLE_ID, 
    JOB_TITLE_SRCID, 
    JOB_TITLE_DESC, 
    SOURCE_SYSTEM, 
    SOURCE_TABLE, 
    INSERT_DT, 
    UPDATE_DT)
VALUES (BL_3NF.JOBS_SEQ.NEXTVAL, 
    NVL(SRC.JOB_TITLE_SRCID, 'n/a'), 
    NVL(SRC.JOB_TITLE_DESC, 'n/a'), 
    SRC.SOURCE_SYSTEM, 
    SRC.SOURCE_TABLE,
    SYSDATE, 
    SYSDATE);
    
L_ROWS_PROCESSED := SQL%ROWCOUNT;
L_CONTEXT := 'LOADING CE_JOB_TITLES FINISHED';
PROC_LOG(L_PACKAGE_NAME, L_PROCEDURE_NAME, L_TABLE_NAME, L_CONTEXT, 'PROCEDURE END', L_ROWS_PROCESSED, SYSDATE);

COMMIT;

EXCEPTION 
    WHEN OTHERS THEN 
        L_CONTEXT := 'ERROR LOADING CE_JOB_TITLES';
        PROC_LOG(L_PACKAGE_NAME, L_PROCEDURE_NAME, L_TABLE_NAME, L_CONTEXT, 'ERROR', NULL, SYSDATE);
        ROLLBACK;
        RAISE;

END PROC_LOAD_CE_JOB_TITLES;

END PKG_LOAD_3NF_CE_JOB_TITLES;         
/


Alter system set "_system_trig_enabled"=FALSE;

alter database datafile '/opt/oracle/oradata/XE/users01.dbf' resize 12 G;

purge recyclebin;

Select name, to_char (bytes/1024/1024/1024,'99,990.0')||'GB'datafile_size from v$datafile;


select nvl(b.tablespace_name
     , nvl(a.tablespace_name, 'UNKOWN')) name
     , kbytes_alloc / 1024 / 1024 gbytes_allocated
     , (kbytes_alloc-nvl(kbytes_free,0)) / 1024 / 1024 gbytes_used
     , nvl(kbytes_free,0) / 1024 / 1024 gbytes_free
     , to_char(((kbytes_alloc-nvl(kbytes_free,0))/kbytes_alloc)*100, 'FM990.0') || '%' pct_used
from (select sum(bytes)/1024 Kbytes_free
           , tablespace_name
      from sys.dba_free_space
      group by tablespace_name ) a
   , (select sum(bytes)/1024 Kbytes_alloc
           , sum(maxbytes)/1024 Kbytes_max
           , tablespace_name
      from sys.dba_data_files
      group by tablespace_name
      -----------
      union all
      -----------
      select sum(bytes)/1024 Kbytes_alloc
           , sum(maxbytes)/1024 Kbytes_max
           , tablespace_name
      from sys.dba_temp_files
      group by tablespace_name) b
where a.tablespace_name (+) = b.tablespace_name;

select tablespace_name from all_tables where owner = 'USR00' and table_name = 'Z303';

alter tablespace temp COALESCE;
-------------------------------------------------------------------------------

drop type BlckFreeSpaceSet;

drop type BlckFreeSpace;

 

create type BlckFreeSpace as object

(

 seg_owner varchar2(30),

 seg_type varchar2(30),

 seg_name varchar2(100),

 fs1 number,

 fs2 number,

 fs3 number,

 fs4 number,

 fb  number

 );

 

create type BlckFreeSpaceSet as table of  BlckFreeSpace;

 

create or replace function BlckFreeSpaceFunc (seg_owner IN varchar2, seg_type in varchar2 default null) return BlckFreeSpaceSet

pipelined

is

   outRec BlckFreeSpace := BlckFreeSpace(null,null,null,null,null,null,null,null);

   fs1_b number;

   fs2_b number;

   fs3_b number;

   fs4_b number;

   fs1_bl number;

   fs2_bl number;

   fs3_bl number;

   fs4_bl number;

   fulb number;

   fulbl number;

   u_b number;

   u_bl number;

begin

  for rec in (select s.owner,s.segment_name,s.segment_type from dba_segments s where owner = seg_owner and segment_type = nvl(seg_type,segment_type) )


    dbms_space.space_usage(

      segment_owner      => rec.owner,

      segment_name       => rec.segment_name,

      segment_type       => rec.segment_type,

      fs1_bytes          => fs1_b,

      fs1_blocks         => fs1_bl,

      fs2_bytes          => fs2_b,

      fs2_blocks         => fs2_bl,

      fs3_bytes          => fs3_b,

      fs3_blocks         => fs3_bl,

      fs4_bytes          => fs4_b,

      fs4_blocks         => fs4_bl,

      full_bytes         => fulb,

      full_blocks        => fulbl,

      unformatted_blocks => u_bl,

      unformatted_bytes  => u_b

   );

 

   outRec.seg_owner := rec.owner;

   outRec.seg_type := rec.segment_type;

   outRec.seg_name := rec.segment_name;

  

   outRec.fs1 := fs1_bl;

   outRec.fs2 := fs2_bl;

   outRec.fs3 := fs3_bl;

   outRec.fs4 := fs4_bl;

   outRec.fb  := fulbl;

 

   Pipe Row (outRec);

 

  end loop;

  return;

end;

/




