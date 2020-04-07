/* 
 * TABLE: dm.DimAdjuster 
 */

CREATE TABLE dm.DimAdjuster(
    adjuster_SK         int            IDENTITY(0,1),
    adjusterID          int            NULL,
    adjusterName        varchar(50)    NULL,
    adjusterTRGUname    varchar(50)    NULL,
    managerName         varchar(50)    NULL,
    groupManagerName    varchar(50)    NULL,
    department          varchar(59)    NULL,
    audit_Insert_Dt     datetime       DEFAULT GetDate() NULL,
    audit_Update_Dt     datetime       DEFAULT GetDate() NULL,
    ins_Proc_ID         int            NULL,
    upd_Proc_ID         int            NULL,
    is_Deleted          bit            DEFAULT 0 NULL,
    is_Active           bit            DEFAULT 0 NULL,
    CONSTRAINT PK_DimAdjuster PRIMARY KEY CLUSTERED (adjuster_SK)
)
go




