CREATE OR REPLACE PACKAGE PKG_LOAD_DIM_CUSTOMERS AS
/* ============================================================================
    NAME:   PKG_LOAD_DIM_CUSTOMERS
    
    GOAL:   TO LOAD DATA FROM 3NF TO DIM_CUSTOMERS
    ==========================================================================*/
    L_PACKAGE_NAME      CONSTANT VARCHAR2(2000) := 'PKG_LOAD_DIM_CUSTOMERS';
    
PROCEDURE PROC_LOAD_DIM_CUSTOMERS;

END PKG_LOAD_DIM_CUSTOMERS;