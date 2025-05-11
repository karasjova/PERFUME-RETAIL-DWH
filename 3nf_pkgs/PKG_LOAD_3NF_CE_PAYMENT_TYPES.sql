-------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE PKG_LOAD_3NF_CE_PAYMENT_TYPES AS
/* ============================================================================
    name:   PKG_LOAD_3NF_CE_PAYMENT_TYPES
    
    GOAL:   TO LOAD DATA FROM SRC TO 3nF_CE_PAYMENT_TYPES 
    ==========================================================================*/
    L_PACKAGE_NAME      CONSTANT VARCHAR2(2000) := 'PKG_LOAD_3NF_CE_PAYMENT_TYPES';
    
PROCEDURE PROC_LOAD_CE_PAYMENT_TYPES;

END PKG_LOAD_3NF_CE_PAYMENT_TYPES;
