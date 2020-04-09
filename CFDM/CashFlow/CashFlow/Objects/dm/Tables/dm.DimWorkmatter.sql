/* 
 * TABLE: dm.DimWorkmatter 
 */

CREATE TABLE dm.DimWorkmatter(
    workMatter_SK                int             IDENTITY(0,1),
    workmatternumber             varchar(64)     NULL,
    workmatterDescription        varchar(512)    NULL,
    workmatterTypeDescription    varchar(64)     NULL,
    workmatterStatus             varchar(64)     NULL,
    specialtrackinggroup         varchar(64)     NULL,
    account                      varchar(64)     NULL,
    audit_Insert_Dt              datetime        DEFAULT GetDate() NULL,
    audit_Update_Dt              datetime        DEFAULT GetDate() NULL,
    ins_Proc_ID                  int             NULL,
    upd_Proc_ID                  int             NULL,
    is_Deleted                   bit             DEFAULT 0 NULL,
    is_Active                    bit             DEFAULT 0 NULL,
    CONSTRAINT PK_DimWorkmatter PRIMARY KEY CLUSTERED (workMatter_SK)
)
go



