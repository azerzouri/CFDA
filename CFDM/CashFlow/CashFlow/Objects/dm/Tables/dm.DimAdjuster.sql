/* 
 * TABLE: dm.DimAdjuster 
 */

CREATE TABLE dm.DimAdjuster(
    adjuster_SK         int            IDENTITY(0,1),
    adjusterName        varchar(64)    NULL,
    adjusterTRGUname    varchar(64)    NULL,
    emailAddress        AS             adjusterTRGUname+'@trg.com' PERSISTED,
    managerName         varchar(64)    NULL,
    groupManagerName    varchar(64)    NULL,
    department          varchar(512)    NULL,
    audit_Insert_Dt     datetime       DEFAULT GetDate() NULL,
    audit_Update_Dt     datetime       DEFAULT GetDate() NULL,
    ins_Proc_ID         int            NULL,
    upd_Proc_ID         int            NULL,
    is_Deleted          bit            DEFAULT 0 NULL,
    is_Active           bit            DEFAULT 0 NULL,
    CONSTRAINT PK_DimAdjuster PRIMARY KEY CLUSTERED (adjuster_SK)
)
go



