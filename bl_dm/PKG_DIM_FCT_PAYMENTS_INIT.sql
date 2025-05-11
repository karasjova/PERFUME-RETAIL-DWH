CREATE OR REPLACE PACKAGE PKG_LOAD_FCT_PAYMENTS_INIT AS
/* ============================================================================
    NAME:   PKG_LOAD_FCT_PAYMENTS_INIT
    
    GOAL:   TO LOAD DATA FROM 3NF TO FCT_PAYMENTS
    ==========================================================================*/
    L_PACKAGE_NAME      CONSTANT VARCHAR2(2000) := 'PKG_LOAD_FCT_PAYMENTS_INIT';
    
PROCEDURE PROC_LOAD_FCT_PAYMENTS_INIT;

END PKG_LOAD_FCT_PAYMENTS_INIT;