/* 
 * TABLE: dm.DimExposure 
 */

CREATE TABLE dm.DimExposure(
    Exposure_SK        int            IDENTITY(0,1),
    exposureNo         varchar(50)    NULL,
    insuredName        varchar(50)    NULL,
    insuredLocation    varchar(50)    NULL,
    exposureStatus     varchar(50)    NULL,
    audit_Insert_Dt    datetime       DEFAULT GetDate() NULL,
    audit_Update_Dt    datetime       DEFAULT GetDate() NULL,
    ins_Proc_ID        int            NULL,
    upd_Proc_ID        int            NULL,
    is_Deleted         bit            DEFAULT 0 NULL,
    is_Active          bit            DEFAULT 0 NULL,
    CONSTRAINT PK_DimExposure PRIMARY KEY CLUSTERED (Exposure_SK)
)
go



