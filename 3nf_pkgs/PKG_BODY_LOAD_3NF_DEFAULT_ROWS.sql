-------------------------------
CREATE OR REPLACE PACKAGE BODY PKG_LOAD_3NF_DEFAULT_ROWS AS

PROCEDURE PROC_LOAD_DEFAULT_ROWS IS

    L_PROCEDURE_NAME    VARCHAR2(2000) := 'PROC_LOAD_DEFAULT_ROWS';
    L_TABLE_NAME        VARCHAR2(2000) := 'BL_3NF_all_tables ';
    L_ROWS_PROCESSED    NUMBER;
    L_CONTEXT           VARCHAR2(2000) := 'LOADING DEFAULT_ROWS STARTS';

BEGIN

INSERT INTO CE_CITIES (CITY_ID, CITY_SRCID, CITY_NAME, SOURCE_SYSTEM, SOURCE_TABLE, INSERT_DT, UPDATE_DT) 
    VALUES (-1, 'n/a', 'n/a', 'n/a',  'n/a', SYSDATE, SYSDATE);
    
COMMIT;

INSERT INTO CE_JOB_TITLES (JOB_TITLE_ID, JOB_TITLE_SRCID, JOB_TITLE_DESC, SOURCE_SYSTEM, SOURCE_TABLE, INSERT_DT, UPDATE_DT) 
    VALUES (-1, 'n/a', 'n/a', 'n/a',  'n/a', SYSDATE, SYSDATE);
    
COMMIT;

INSERT INTO CE_SALES_CHANNELS (SALES_CHANNEL_ID, SALES_CHANNEL_NAME, SALES_CHANNEL_SRCID, SOURCE_SYSTEM, SOURCE_TABLE, INSERT_DT, UPDATE_DT) 
    VALUES (-1, 'n/a', 'n/a', 'n/a',  'n/a', SYSDATE, SYSDATE);
    
COMMIT;

INSERT INTO  CE_PAYMENT_TYPES (PAYMENT_TYPE_ID, PAYMENT_TYPE_SRCID, PAYMENT_TYPE_DESC, SOURCE_SYSTEM, SOURCE_TABLE, INSERT_DT, UPDATE_DT) 
    VALUES (-1, 'n/a', 'n/a', 'n/a',  'n/a', SYSDATE, SYSDATE);
    
COMMIT;

INSERT INTO  CE_PRODUCT_CATEGORIES (PRODUCT_CATEGORY_ID, PRODUCT_CATEGORY_SRCID, PRODUCT_CATEGORY_NAME, SOURCE_SYSTEM, SOURCE_TABLE, INSERT_DT, UPDATE_DT) 
    VALUES (-1, 'n/a', 'n/a', 'n/a',  'n/a', SYSDATE, SYSDATE);
    
COMMIT;


INSERT INTO  CE_CITY_DISTRICTS (CITY_DISTRICT_ID, CITY_DISTRICT_SRCID, CITY_DISTRICT_NAME, SOURCE_SYSTEM, SOURCE_TABLE, CITY_ID, INSERT_DT, UPDATE_DT) 
    VALUES (-1, 'n/a', 'n/a', 'n/a',  'n/a', -1, SYSDATE, SYSDATE);
    
COMMIT;

INSERT INTO  CE_STORES (STORE_ID, STORE_SRCID, STORE_NAME, SOURCE_SYSTEM, SOURCE_TABLE, ADDRESS_LINE_DESC, PHONE_NUMBER, CITY_DISTRICT_ID, INSERT_DT, UPDATE_DT) 
    VALUES (-1, 'n/a', 'n/a', 'n/a',  'n/a','n/a', 'n/a', -1, SYSDATE, SYSDATE);
    
COMMIT;

INSERT INTO  CE_CUSTOMERS (CUSTOMER_ID, CUSTOMER_NAME, CUSTOMER_SRCID, SOURCE_SYSTEM, SOURCE_TABLE, ADDRESS_LINE_DESC, EMAIL, PHONE_NUMBER, CITY_DISTRICT_ID, INSERT_DT, UPDATE_DT) 
    VALUES (-1, 'n/a', 'n/a', 'n/a',  'n/a','n/a', 'n/a', 'n/a', -1, SYSDATE, SYSDATE);
    
COMMIT;

INSERT INTO  CE_PRODUCTS (PRODUCT_ID , PRODUCT_NAME, PRODUCT_SRCID, SOURCE_SYSTEM, SOURCE_TABLE, PRODUCT_PRICE, PRODUCT_CATEGORY_ID, INSERT_DT, UPDATE_DT) 
    VALUES (-1, 'n/a', 'n/a', 'n/a',  'n/a', -1, -1, SYSDATE, SYSDATE);
    
COMMIT;
       
       
INSERT INTO  CE_EMPLOYEES_SCD (EMPLOYEE_ID, EMPLOYEE_SRCID, FIRST_NAME, LAST_NAME, SOURCE_SYSTEM,  SOURCE_TABLE,  EMAIL, PHONE_NUMBER, START_DT, END_DATE, IS_ACTIVE, INSERT_DT, UPDATE_DT, JOB_TITLE_ID) 
    VALUES (-1, 'n/a', 'n/a', 'n/a',  'n/a', 'n/a', 'n/a', 'n/a', '31-DEC-9999','31-DEC-9999','n/a', SYSDATE, SYSDATE, -1);
    
COMMIT;

L_ROWS_PROCESSED := SQL%ROWCOUNT;
L_CONTEXT := 'LOADING DEFAULT_ROWS FINISHED';
PROC_LOG(L_PACKAGE_NAME, L_PROCEDURE_NAME, L_TABLE_NAME, L_CONTEXT, 'PROCEDURE END', L_ROWS_PROCESSED, SYSDATE);

COMMIT;

EXCEPTION 
    WHEN OTHERS THEN 
        L_CONTEXT := 'ERROR LOADING DEFAULT_ROWS';
        PROC_LOG(L_PACKAGE_NAME, L_PROCEDURE_NAME, L_TABLE_NAME, L_CONTEXT, 'ERROR', NULL, SYSDATE);
        ROLLBACK;
        RAISE;
    
END PROC_LOAD_DEFAULT_ROWS;

END PKG_LOAD_3NF_DEFAULT_ROWS;           
/
