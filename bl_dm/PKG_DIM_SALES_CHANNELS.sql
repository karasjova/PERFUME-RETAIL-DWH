CREATE OR REPLACE PACKAGE PKG_LOAD_DIM_SALES_CHANNELS AS
/* ============================================================================
    NAME:   PKG_LOAD_DIM_SALES_CHANNELS
    
    GOAL:   TO LOAD DATA FROM 3NF TO DIM_SALES_CHANNELS
    ==========================================================================*/
    L_PACKAGE_NAME      CONSTANT VARCHAR2(2000) := 'PKG_LOAD_DIM_SALES_CHANNELS';
    
PROCEDURE PROC_LOAD_DIM_SALES_CHANNELS;

END PKG_LOAD_DIM_SALES_CHANNELS;