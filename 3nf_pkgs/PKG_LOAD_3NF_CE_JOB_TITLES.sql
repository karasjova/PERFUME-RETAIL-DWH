-------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE PKG_LOAD_3NF_CE_JOB_TITLES AS
/* ============================================================================
    name:   PKG_LOAD_3NF_CE_JOB_TITLES
    
    GOAL:   TO LOAD DATA FROM SRC TO 3nF_CE_JOB_TITLES
    ==========================================================================*/
    L_PACKAGE_NAME      CONSTANT VARCHAR2(2000) := 'PKG_LOAD_3NF_CE_JOB_TITLES';
    
PROCEDURE PROC_LOAD_CE_JOB_TITLES;

END PKG_LOAD_3NF_CE_JOB_TITLES;
/
