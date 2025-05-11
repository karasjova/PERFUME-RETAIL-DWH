-------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE PKG_LOAD_3NF_CE_CUSTOMERS AS
/* ============================================================================
    name:   PKG_LOAD_3NF_CE_CUSTOMERS
    
    GOAL:   TO LOAD DATA FROM SRC TO 3nF_CE_CUSTOMERS
    ==========================================================================*/
    L_PACKAGE_NAME      CONSTANT VARCHAR2(2000) := 'PKG_LOAD_3NF_CE_CUSTOMERS';
    
PROCEDURE PROC_LOAD_CE_CUSTOMERS;

END PKG_LOAD_3NF_CE_CUSTOMERS;
/
