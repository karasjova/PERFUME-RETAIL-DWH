-------------------------------
CREATE OR REPLACE PACKAGE BODY PKG_LOAD_3NF_CE_CITY_DISTRICTS AS

PROCEDURE PROC_LOAD_CE_CITY_DISTRICTS IS

    L_PROCEDURE_NAME    VARCHAR2(2000) := 'PROC_LOAD_CE_CITY_DISTRICTS';
    L_TABLE_NAME        VARCHAR2(2000) := 'CE_CITY_DISTRICTS';
    L_ROWS_PROCESSED    NUMBER;
    L_CONTEXT           VARCHAR2(2000) := 'LOADING CE_CITY_DISTRICTS STARTS';
    L_ROW_COUNT_BEFORE  NUMBER;
    L_ROW_COUNT_AFTER   NUMBER;
    TYPE t_ref_c IS REF CURSOR;
    ref_cur    t_ref_c;     
    
BEGIN

OPEN ref_cur FOR 'SELECT COUNT(*)FROM BL_3NF.CE_CITY_DISTRICTS';

FETCH ref_cur INTO L_ROW_COUNT_BEFORE;
CLOSE ref_cur;

PROC_LOG(L_PACKAGE_NAME, L_PROCEDURE_NAME, L_TABLE_NAME, L_CONTEXT, 'PROCEDURE STARTS', L_ROW_COUNT_BEFORE, SYSDATE);

--truncate table mapping_city_districts
--INSERT INTO   mapping_city_districts (city_district_id, city_district_srcid, city_district_name, source_system, source_table, city_name, insert_dt, update_dt) 
--    WITH distr_data AS (
--        SELECT DISTINCT
--            upper(district) as city_district_srcid, 
--            upper(district) as city_district_name,
--            'business_entities' as  source_system,
--            'src_business_entities' as source_table,
--            city,
--            SYSDATE as insert_dt,
--            SYSDATE as update_dt
--        FROM
--            BL_3NF.ce_cities  c 
--            left join sa_source.src_business_entities s on  upper(c.city_name) = upper(s.city) 
--       UNION ALL
--        SELECT DISTINCT
--            upper(district) as city_district_srcid, 
--            upper(district) as city_district_name,
--            'individual_customers' as  source_system,
--            'src_individual_customers' as source_table,
--            city,
--            SYSDATE as insert_dt,
--            SYSDATE as update_dt
--        FROM
--             BL_3NF.ce_cities  c 
--             left join sa_source.src_individual_customers s on upper(c.city_name) = upper(s.city) 
--        UNION ALL
--         SELECT DISTINCT
--            upper(s.business_entity_district) as city_district_srcid, 
--            upper(s.business_entity_district) as city_district_name,
--            'business_entities' as  source_system,
--            'src_business_entities' as source_table,
--            s.business_entity_city,
--            SYSDATE as insert_dt,
--            SYSDATE as update_dt
--        FROM
--            BL_3NF.ce_cities  c 
--            left join sa_source.src_business_entities s on  upper(c.city_name) = upper(s.business_entity_city) 
--        UNION ALL
--        SELECT DISTINCT
--            upper(s.business_entity_district) as city_district_srcid, 
--            upper(s.business_entity_district) as city_district_name,
--            'individual_customers' as  source_system,
--            'src_individual_customers' as source_table,
--            s.business_entity_city,
--            SYSDATE as insert_dt,
--            SYSDATE as update_dt
--        FROM
--             BL_3NF.ce_cities  c 
--             left join sa_source.src_individual_customers s on upper(c.city_name) = upper(s.business_entity_city) 
--             )
--SELECT distr_seq.nextval, nvl(city_district_srcid, 'n/a'), nvl(city_district_name, 'n/a'), source_system, source_table, city, insert_dt, update_dt
--FROM distr_data;
--
--commit;

MERGE INTO BL_3NF.CE_CITY_DISTRICTS TARG
USING 
       (SELECT DISTINCT
            UPPER(TRIM(CITY_DISTRICT_SRCID)) AS CITY_DISTRICT_SRCID, 
            UPPER(TRIM(CITY_DISTRICT_NAME)) AS CITY_DISTRICT_NAME,
            'manual' AS  SOURCE_SYSTEM,
            'manual' AS SOURCE_TABLE,
            M.CITY_NAME,
            C.CITY_ID AS CITY_ID,
            SYSDATE AS INSERT_DT,
            SYSDATE AS UPDATE_DT
        FROM
           MAPPING_CITY_DISTRICTS M
           JOIN BL_3NF.CE_CITIES C ON UPPER(M.CITY_NAME) = UPPER(C.CITY_NAME)
        ) SRC
ON  (TARG.CITY_DISTRICT_SRCID = SRC.CITY_DISTRICT_SRCID
AND TARG.SOURCE_SYSTEM = SRC.SOURCE_SYSTEM
AND TARG.SOURCE_TABLE = SRC.SOURCE_TABLE)
WHEN MATCHED THEN UPDATE SET 
    TARG.CITY_DISTRICT_NAME = SRC.CITY_DISTRICT_NAME,
    TARG.CITY_ID = SRC.CITY_ID,
    TARG.UPDATE_DT = SYSDATE
    WHERE TARG.CITY_DISTRICT_NAME <> SRC.CITY_DISTRICT_NAME
    or TARG.CITY_ID <> SRC.CITY_ID
WHEN NOT MATCHED THEN INSERT 
    (CITY_DISTRICT_ID, 
    CITY_DISTRICT_SRCID, 
    SOURCE_SYSTEM, 
    SOURCE_TABLE, 
    CITY_DISTRICT_NAME,
    CITY_ID,
    INSERT_DT, 
    UPDATE_DT)
VALUES (BL_3NF.DISTR_SEQ.NEXTVAL,
    NVL(SRC.CITY_DISTRICT_SRCID, 'n/a'), 
    SRC.SOURCE_SYSTEM, 
    SRC.SOURCE_TABLE, 
    NVL(SRC.CITY_DISTRICT_NAME, 'n/a'), 
    SRC.CITY_ID,
    SYSDATE, 
    SYSDATE);

L_ROWS_PROCESSED := SQL%ROWCOUNT;
L_CONTEXT := 'LOADING CE_CITY_DISTRICTS FINISHED';
PROC_LOG(L_PACKAGE_NAME, L_PROCEDURE_NAME, L_TABLE_NAME, L_CONTEXT, 'PROCEDURE END', L_ROWS_PROCESSED, SYSDATE);

COMMIT;

EXCEPTION 
    WHEN OTHERS THEN 
        L_CONTEXT := 'ERROR LOADING CE_CITY_DISTRICTS';
        PROC_LOG(L_PACKAGE_NAME, L_PROCEDURE_NAME, L_TABLE_NAME, L_CONTEXT, 'ERROR', NULL, SYSDATE);
        ROLLBACK;
        RAISE;
    
END PROC_LOAD_CE_CITY_DISTRICTS;
          
END PKG_LOAD_3NF_CE_CITY_DISTRICTS;           
/
