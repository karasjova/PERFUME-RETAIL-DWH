-------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE PKG_LOAD_3NF_CE_STORES AS
/* ============================================================================
    name:   PKG_LOAD_3NF_CE_STORES
    
    GOAL:   TO LOAD DATA FROM SRC TO 3nF_CE_STORES
    ==========================================================================*/
    L_PACKAGE_NAME      CONSTANT VARCHAR2(2000) := 'PKG_LOAD_3NF_CE_STORES';
    
PROCEDURE PROC_LOAD_CE_STORES;

END PKG_LOAD_3NF_CE_STORES;
