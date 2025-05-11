CREATE OR REPLACE PACKAGE PKG_LOAD_DIM_DATE AS
/* ============================================================================
    NAME:   PKG_LOAD_DIM_DATE
    
    GOAL:   TO LOAD DATA FROM 3NF TO DIM_DATE
    ==========================================================================*/
    L_PACKAGE_NAME      CONSTANT VARCHAR2(2000) := 'PKG_LOAD_DIM_DATE';
    
PROCEDURE PROC_LOAD_DIM_DATE;

END PKG_LOAD_DIM_DATE;