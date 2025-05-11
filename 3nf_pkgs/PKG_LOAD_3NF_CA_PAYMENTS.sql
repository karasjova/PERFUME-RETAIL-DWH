-------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE PKG_LOAD_3NF_CA_PAYMENTS_INIT AS
/* ============================================================================
    name:   PKG_LOAD_3NF_CA_PAYMENTS_INIT
    
    GOAL:   TO LOAD DATA FROM SRC TO 3nF_CA_PAYMENTS
    ==========================================================================*/
    L_PACKAGE_NAME      CONSTANT VARCHAR2(2000) := 'PKG_LOAD_3NF_CA_PAYMENTS_INIT';
    
PROCEDURE PROC_LOAD_CA_PAYMENTS_INIT;

END PKG_LOAD_3NF_CA_PAYMENTS_INIT;
/
