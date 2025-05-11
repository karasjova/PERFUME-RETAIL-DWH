-------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE PKG_LOAD_3NF_CE_PRODUCTS AS
/* ============================================================================
    name:   PKG_LOAD_3NF_CE_PRODUCTS
    
    GOAL:   TO LOAD DATA FROM SRC TO 3nF_CE_PRODUCTS
    ==========================================================================*/
    L_PACKAGE_NAME      CONSTANT VARCHAR2(2000) := 'PKG_LOAD_3NF_CE_PRODUCTS';
    
PROCEDURE PROC_LOAD_CE_PRODUCTS;

END PKG_LOAD_3NF_CE_PRODUCTS;
/
