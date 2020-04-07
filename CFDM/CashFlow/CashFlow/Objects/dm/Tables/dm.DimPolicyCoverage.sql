/* 
 * TABLE: dm.DimPolicyCoverage 
 */

CREATE TABLE dm.DimPolicyCoverage(
    policyCoverage_SK        int             IDENTITY(0,1),
    policyCoverage           varchar(50)     NULL,
    policyProduct            varchar(50)     NULL,
    policySubproduct         varchar(50)     NULL,
    claimBasisDescription    varchar(255)    NULL,
    audit_Insert_Dt          datetime        DEFAULT GetDate() NULL,
    audit_Update_Dt          datetime        DEFAULT GetDate() NULL,
    ins_Proc_ID              int             NULL,
    upd_Proc_ID              int             NULL,
    is_Deleted               bit             DEFAULT 0 NULL,
    is_Active                bit             DEFAULT 0 NULL,
    CONSTRAINT PK_DimPolicyCoverage PRIMARY KEY CLUSTERED (policyCoverage_SK)
)
go




