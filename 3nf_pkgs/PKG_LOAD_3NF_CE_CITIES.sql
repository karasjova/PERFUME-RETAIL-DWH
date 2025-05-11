-------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE PKG_LOAD_3NF_CE_CITIES AS
/* ============================================================================
    name:   PKG_LOAD_TO_3NF_CE_CITIES
    
    GOAL:   TO LOAD DATA FROM SRC TO 3nF_CE_CITIES
    ==========================================================================*/
    L_PACKAGE_NAME      CONSTANT VARCHAR2(2000) := 'PKG_LOAD_3NF_CE_CITIES';
    
PROCEDURE PROC_LOAD_CE_CITIES;

END PKG_LOAD_3NF_CE_CITIES;
/
