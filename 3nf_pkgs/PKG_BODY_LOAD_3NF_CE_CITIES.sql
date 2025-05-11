-------------------------------
CREATE OR REPLACE PACKAGE BODY PKG_LOAD_3NF_CE_CITIES AS

PROCEDURE PROC_LOAD_CE_CITIES IS

    L_PROCEDURE_NAME    VARCHAR2(2000) := 'PROC_LOAD_CE_CITIES';
    L_TABLE_NAME        VARCHAR2(2000) := 'CE_CITIES';
    L_ROWS_PROCESSED    NUMBER;
    L_CONTEXT           VARCHAR2(2000) := 'LOADING CE_CITIES STARTS';
    L_ROW_COUNT_BEFORE  NUMBER;
    L_ROW_COUNT_AFTER   NUMBER;
    TYPE t_ref_c IS REF CURSOR;
    ref_cur    t_ref_c;     
    
BEGIN

OPEN ref_cur FOR 'SELECT COUNT(*)FROM BL_3NF.CE_CITIES';

FETCH ref_cur INTO L_ROW_COUNT_BEFORE;
CLOSE ref_cur;

PROC_LOG(L_PACKAGE_NAME, L_PROCEDURE_NAME, L_TABLE_NAME, L_CONTEXT, 'PROCEDURE STARTS', L_ROW_COUNT_BEFORE, SYSDATE);    
--
--INSERT INTO BL_CL.mapping_ce_cities (city_id, city_srcid, city_name, source_system, source_table, insert_dt, update_dt) 
--WITH cities_data AS (
--        SELECT DISTINCT
--            upper(city) as city_srcid, 
--            upper(city)  as city_name,
--            'business_entities' as  source_system,
--            'src_business_entities' as source_table,
--            SYSDATE as insert_dt,
--            SYSDATE as update_dt
--        FROM
--            src_business_entities
--        UNION ALL
--        SELECT DISTINCT
--            upper(city)  as city_srcid, 
--            upper(city)  as city_name,
--            'individual_customers' as  source_system,
--            'src_individual_customers' as source_table,
--            SYSDATE as insert_dt,
--            SYSDATE as update_dt
--        FROM
--             src_individual_customers
--         UNION ALL
--          SELECT DISTINCT
--            upper(business_entity_city) as city_srcid, 
--            upper(business_entity_city) as city_name,
--            'business_entities' as  source_system,
--            'src_business_entities' as source_table,
--            SYSDATE as insert_dt,
--            SYSDATE as update_dt
--        FROM
--            src_business_entities
--         UNION ALL
--         SELECT DISTINCT
--            upper(business_entity_city)  as city_srcid, 
--            upper(business_entity_city)  as city_name,
--            'individual_customers' as  source_system,
--            'src_individual_customers' as source_table,
--            SYSDATE as insert_dt,
--            SYSDATE as update_dt
--        FROM
--             src_individual_customers)
--SELECT cities_seq.nextval, nvl(city_srcid, 'n/a'), nvl(city_name, 'n/a'), source_system, source_table, insert_dt, update_dt
--FROM cities_data;

--COMMIT;

MERGE INTO BL_3NF.CE_CITIES TARG
USING 
       (SELECT DISTINCT
            UPPER(TRIM(CITY_SRCID)) AS CITY_SRCID, 
            UPPER(TRIM(CITY_NAME)) AS CITY_NAME,
            'manual' AS  SOURCE_SYSTEM,
            'manual' AS SOURCE_TABLE,
            SYSDATE AS INSERT_DT,
            SYSDATE AS UPDATE_DT
        FROM
           MAPPING_CE_CITIES
        ) SRC
ON  (TARG.CITY_SRCID = SRC.CITY_SRCID
AND TARG.SOURCE_SYSTEM = SRC.SOURCE_SYSTEM
AND TARG.SOURCE_TABLE = SRC.SOURCE_TABLE)
WHEN MATCHED THEN UPDATE SET 
    TARG.CITY_NAME = SRC.CITY_NAME,
    TARG.UPDATE_DT = SYSDATE
    WHERE TARG.CITY_NAME <> SRC.CITY_NAME
WHEN NOT MATCHED THEN INSERT 
    (CITY_ID, 
    CITY_SRCID, 
    SOURCE_SYSTEM, 
    SOURCE_TABLE, 
    CITY_NAME,
    INSERT_DT, 
    UPDATE_DT)
VALUES (BL_3NF.CITIES_SEQ.NEXTVAL,
    NVL(SRC.CITY_SRCID, 'n/a'), 
    SRC.SOURCE_SYSTEM, 
    SRC.SOURCE_TABLE, 
    NVL(SRC.CITY_NAME, 'n/a'), 
    SYSDATE, 
    SYSDATE);

L_ROWS_PROCESSED := SQL%ROWCOUNT;
L_CONTEXT := 'LOADING CE_CITIES FINISHED';
PROC_LOG(L_PACKAGE_NAME, L_PROCEDURE_NAME, L_TABLE_NAME, L_CONTEXT, 'PROCEDURE END', L_ROWS_PROCESSED, SYSDATE);

COMMIT;

EXCEPTION 
    WHEN OTHERS THEN 
        L_CONTEXT := 'ERROR LOADING CE_CITIES';
        PROC_LOG(L_PACKAGE_NAME, L_PROCEDURE_NAME, L_TABLE_NAME, L_CONTEXT, 'ERROR', NULL, SYSDATE);
        ROLLBACK;
        RAISE;
    
END PROC_LOAD_CE_CITIES;    

END PKG_LOAD_3NF_CE_CITIES;           
/
