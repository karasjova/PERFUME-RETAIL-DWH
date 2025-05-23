-------------------------------
CREATE OR REPLACE PACKAGE BODY PKG_LOAD_3NF_CE_EMPLOYEES_SCD AS

PROCEDURE PROC_LOAD_CE_EMPLOYEES_SCD IS

    L_PROCEDURE_NAME    VARCHAR2(2000) := 'PROC_LOAD_CE_EMPLOYEES_SCD';
    L_TABLE_NAME        VARCHAR2(2000) := 'CE_EMPLOYEES_SCD ';
    L_ROWS_PROCESSED    NUMBER;
    L_CONTEXT           VARCHAR2(2000) := 'LOADING CE_EMPLOYEES_SCD STARTS';
    L_ROW_COUNT_BEFORE  NUMBER;
    L_ROW_COUNT_AFTER   NUMBER;
    TYPE T_REF_C IS REF CURSOR;
    REF_CUR    T_REF_C;     
    
BEGIN

OPEN REF_CUR FOR 'SELECT COUNT(*)FROM BL_3NF.CE_EMPLOYEES_SCD';

FETCH REF_CUR INTO L_ROW_COUNT_BEFORE;
CLOSE REF_CUR;

PROC_LOG(L_PACKAGE_NAME, L_PROCEDURE_NAME, L_TABLE_NAME, L_CONTEXT, 'PROCEDURE STARTS', L_ROW_COUNT_BEFORE, SYSDATE);

MERGE INTO BL_3NF.CE_EMPLOYEES_SCD TARG
USING 
       (SELECT DISTINCT EMPOYEE_ID AS EMPLOYEE_SRCID,
             FIRST_NAME AS FIRST_NAME, 
             LAST_NAME AS LAST_NAME,
            'business_entities' AS  SOURCE_SYSTEM,
            'src_business_entities' AS SOURCE_TABLE,
            EMPLOYEE_EMAIL AS EMAIL,
            EMPLOYEE_PHONE_NUMBER AS PHONE_NUMBER,
            SYSDATE AS START_DT, 
            '31-DEC-9999'  AS END_DATE, 
            'actual' AS IS_ACTIVE,
            SYSDATE AS INSERT_DT,
            SYSDATE AS UPDATE_DT, 
            JOB_TITLE_ID AS JOB_TITLE_ID
        FROM
            BL_3NF.CE_JOB_TITLES  C 
            LEFT JOIN SRC_BUSINESS_ENTITIES S ON UPPER(S.JOB_TITLE) = UPPER(C.JOB_TITLE_DESC)
            WHERE C.SOURCE_SYSTEM = 'business_entities'
      UNION ALL
        SELECT 
             DISTINCT EMPOYEE_ID AS EMPLOYEE_SRCID,
             FIRST_NAME AS FIRST_NAME, 
             LAST_NAME AS LAST_NAME,
            'individual_customers' AS  SOURCE_SYSTEM,
            'src_individual_customers' AS SOURCE_TABLE,
             EMPLOYEE_EMAIL AS EMAIL,
            EMPLOYEE_PHONE_NUMBER AS PHONE_NUMBER,
            SYSDATE AS START_DT, 
            '31-DEC-9999'  AS END_DATE, 
            'actual' AS IS_ACTIVE,
            SYSDATE AS INSERT_DT,
            SYSDATE AS UPDATE_DT, 
            JOB_TITLE_ID AS JOB_TITLE_ID
        FROM
            BL_3NF.CE_JOB_TITLES  C 
            LEFT JOIN  SRC_INDIVIDUAL_CUSTOMERS S ON UPPER(S.JOB_TITLE) = UPPER(C.JOB_TITLE_DESC)
            WHERE C.SOURCE_SYSTEM = 'individual_customers'
        ) SRC
ON  (TARG.EMPLOYEE_SRCID = SRC.EMPLOYEE_SRCID
    AND TARG.SOURCE_SYSTEM = SRC.SOURCE_SYSTEM
    AND TARG.SOURCE_TABLE = SRC.SOURCE_TABLE)
WHEN MATCHED THEN UPDATE SET 
        TARG.FIRST_NAME = SRC.FIRST_NAME,
        TARG.LAST_NAME = SRC.LAST_NAME,
        TARG.EMAIL = SRC.EMAIL,
        TARG.PHONE_NUMBER = SRC.PHONE_NUMBER,
        TARG.START_DT = SRC.START_DT,
        TARG.END_DATE = SRC.END_DATE,
        TARG.IS_ACTIVE = SRC.IS_ACTIVE,
        TARG.JOB_TITLE_ID = SRC.JOB_TITLE_ID,
        TARG.UPDATE_DT = SYSDATE
    WHERE   TARG.FIRST_NAME <> SRC.FIRST_NAME 
            or TARG.LAST_NAME <> SRC.LAST_NAME
            or TARG.EMAIL <> SRC.EMAIL
            or TARG.PHONE_NUMBER <> SRC.PHONE_NUMBER
            or TARG.START_DT <> SRC.START_DT
            or TARG.END_DATE <> SRC.END_DATE
            or TARG.IS_ACTIVE = SRC.IS_ACTIVE
            or TARG.JOB_TITLE_ID <> SRC.JOB_TITLE_ID
WHEN NOT MATCHED THEN INSERT 
    (EMPLOYEE_ID, 
    EMPLOYEE_SRCID, 
    SOURCE_SYSTEM, 
    SOURCE_TABLE, 
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    PHONE_NUMBER,
    START_DT,
    END_DATE,
    IS_ACTIVE, 
    INSERT_DT, 
    UPDATE_DT, 
    JOB_TITLE_ID)
VALUES (BL_3NF.EMP_SEQ.NEXTVAL,
    NVL(SRC.EMPLOYEE_SRCID, 'n/a'), 
    SRC.SOURCE_SYSTEM, 
    SRC.SOURCE_TABLE, 
    NVL(SRC.FIRST_NAME, 'n/a'), 
    NVL(SRC.LAST_NAME, 'n/a'), 
    NVL(SRC.EMAIL, 'n/a'),
    NVL(SRC.PHONE_NUMBER, 'n/a'),
    SRC.START_DT,
    SRC.END_DATE,
    SRC.IS_ACTIVE,
    SYSDATE, 
    SYSDATE,
    SRC.JOB_TITLE_ID);

L_ROWS_PROCESSED := SQL%ROWCOUNT;
L_CONTEXT := 'LOADING CE_EMPLOYEES_SCD FINISHED';
PROC_LOG(L_PACKAGE_NAME, L_PROCEDURE_NAME, L_TABLE_NAME, L_CONTEXT, 'PROCEDURE END', L_ROWS_PROCESSED, SYSDATE);

COMMIT;

EXCEPTION 
    WHEN OTHERS THEN 
        L_CONTEXT := 'ERROR LOADING CE_CUSTOMERS';
        PROC_LOG(L_PACKAGE_NAME, L_PROCEDURE_NAME, L_TABLE_NAME, L_CONTEXT, 'ERROR', NULL, SYSDATE);
        ROLLBACK;
        RAISE;
    
END PROC_LOAD_CE_EMPLOYEES_SCD;

END PKG_LOAD_3NF_CE_EMPLOYEES_SCD;           
/
