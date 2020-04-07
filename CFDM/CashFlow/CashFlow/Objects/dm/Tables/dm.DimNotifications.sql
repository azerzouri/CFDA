/* 
 * TABLE: dm.DimNotifications 
 */

CREATE TABLE dm.DimNotifications(
    notification_SK    int              IDENTITY(1,1),
    workMatterNo       varchar(50)      NOT NULL,
    comments           varchar(4000)    NULL,
    confidence         varchar(50)      NULL,
    Status             varchar(50)      NULL,
    audit_Insert_Dt    datetime         DEFAULT (getdate()) NULL,
    audit_Update_Dt    datetime         DEFAULT (getdate()) NULL,
    ins_Proc_ID        int              NULL,
    upd_Proc_ID        int              NULL,
    is_Deleted         bit              DEFAULT 0 NULL,
    is_Active          bit              DEFAULT 0 NULL,
    CONSTRAINT PK_DimNotifications PRIMARY KEY CLUSTERED (notification_SK)
)
go




