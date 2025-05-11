-------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE PKG_LOAD_3NF_CE_EMPLOYEES_SCD AS
/* ============================================================================
    name:   PKG_LOAD_3NF_CE_EMPLOYEES_SCD
    
    GOAL:   TO LOAD DATA FROM SRC TO 3nF_CE_EMPLOYEES_SCD
    ==========================================================================*/
    L_PACKAGE_NAME      CONSTANT VARCHAR2(2000) := 'PKG_LOAD_3NF_CE_EMPLOYEES_SCD';
    
PROCEDURE PROC_LOAD_CE_EMPLOYEES_SCD;

END PKG_LOAD_3NF_CE_EMPLOYEES_SCD;
/
