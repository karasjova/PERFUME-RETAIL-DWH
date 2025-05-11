-------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE PKG_LOAD_3NF_CE_CITY_DISTRICTS AS
/* ============================================================================
    name:   PKG_LOAD_3NF_CE_CITY_DISTRICTS
    
    GOAL:   TO LOAD DATA FROM SRC TO 3nF_CE_CITY_DISTRICTS
    ==========================================================================*/
    L_PACKAGE_NAME      CONSTANT VARCHAR2(2000) := 'PKG_LOAD_3NF_CE_CITY_DISTRICTS';
    
PROCEDURE PROC_LOAD_CE_CITY_DISTRICTS;

END PKG_LOAD_3NF_CE_CITY_DISTRICTS;
/
