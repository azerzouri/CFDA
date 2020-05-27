/* 
 * TABLE: dm.DimPolicy 
 */

CREATE TABLE dm.DimPolicy(
    policy_SK          int            IDENTITY(0,1),
    policyNumber        varchar(64)    NULL,
    portfolioCode       varchar(20)    NULL,
    NAICCode            varchar(12)    NULL,
    businessTypeCode    char(2)        NULL,
    audit_Insert_Dt    datetime       DEFAULT GetDate() NULL,
    audit_Update_Dt    datetime       DEFAULT GetDate() NULL,
    ins_Proc_ID        int            NULL,
    upd_Proc_ID        int            NULL,
    is_Deleted         bit            DEFAULT 0 NULL,
    is_Active          bit            DEFAULT 0 NULL,
    CONSTRAINT PK_DimPolicy PRIMARY KEY CLUSTERED (policy_SK)
)
go



