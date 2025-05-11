-------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE PKG_LOAD_3NF_DEFAULT_ROWS AS
/* ============================================================================
    name:   PKG_LOAD_3NF_DEFAULT_ROWS
    
    GOAL:   TO LOAD DEFAULT_ROWS TO 3NF 
    ==========================================================================*/
    L_PACKAGE_NAME      CONSTANT VARCHAR2(2000) := 'PKG_LOAD_3NF_DEFAULT_ROWS';
    
PROCEDURE PROC_LOAD_DEFAULT_ROWS;

END PKG_LOAD_3NF_DEFAULT_ROWS;
/
