CREATE OR REPLACE PACKAGE PKG_LOAD_DIM_PAYMENT_TYPES AS
/* ============================================================================
    NAME:   PKG_LOAD_DIM_PAYMENT_TYPES
    
    GOAL:   TO LOAD DATA FROM 3NF TO DIM_PAYMENT_TYPES
    ==========================================================================*/
    L_PACKAGE_NAME      CONSTANT VARCHAR2(2000) := 'PKG_LOAD_DIM_PAYMENT_TYPES';
    
PROCEDURE PROC_LOAD_DIM_PAYMENT_TYPES;

END PKG_LOAD_DIM_PAYMENT_TYPES;