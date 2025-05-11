CREATE OR REPLACE PACKAGE PKG_LOAD_DIM_STORES AS
/* ============================================================================
    NAME:   PKG_LOAD_DIM_STORES
    
    GOAL:   TO LOAD DATA FROM 3NF TO DIM_STORES
    ==========================================================================*/
    L_PACKAGE_NAME      CONSTANT VARCHAR2(2000) := 'PKG_LOAD_DIM_STORES';
    
PROCEDURE PROC_LOAD_DIM_STORES;

END PKG_LOAD_DIM_STORES;