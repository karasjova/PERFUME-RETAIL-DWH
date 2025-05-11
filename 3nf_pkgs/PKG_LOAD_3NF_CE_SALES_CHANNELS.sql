-------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE PKG_LOAD_3NF_CE_SALES_CHANNELS AS
/* ============================================================================
    name:   PKG_LOAD_3NF_CE_SALES_CHANNELS
    
    GOAL:   TO LOAD DATA FROM SRC TO 3nF_CE_SALES_CHANNELS
    ==========================================================================*/
    L_PACKAGE_NAME      CONSTANT VARCHAR2(2000) := 'PKG_LOAD_3NF_CE_SALES_CHANNELS';
    
PROCEDURE PROC_LOAD_CE_SALES_CHANNELS;

END PKG_LOAD_3NF_CE_SALES_CHANNELS;
/
