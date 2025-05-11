CREATE OR REPLACE PACKAGE PKG_LOAD_DIM_PRODUCTS AS
/* ============================================================================
    NAME:   PKG_LOAD_DIM_PRODUCTS
    
    GOAL:   TO LOAD DATA FROM 3NF TO DIM_PRODUCTS
    ==========================================================================*/
    L_PACKAGE_NAME      CONSTANT VARCHAR2(2000) := 'PKG_LOAD_DIM_PRODUCTS';
    
PROCEDURE PROC_LOAD_DIM_PRODUCTS;

END PKG_LOAD_DIM_PRODUCTS;