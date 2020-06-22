/* 
 * TABLE: dm.DimExposure 
 */

CREATE TABLE dm.DimExposure(
    exposure_SK        int            IDENTITY(0,1),
    claimExposureNo         varchar(64)    NULL,
    insuredName        varchar(256)   NULL,
    exposureStatus     varchar(64)    NULL,
	claimNumber        AS             SUBSTRING(claimExposureNo,0,CHARINDEX('-', claimExposureNo)) PERSISTED,
    audit_Insert_Dt    datetime       DEFAULT GetDate() NULL,
    audit_Update_Dt    datetime       DEFAULT GetDate() NULL,
    ins_Proc_ID        int            NULL,
    upd_Proc_ID        int            NULL,
    is_Deleted         bit            DEFAULT 0 NULL,
    is_Active          bit            DEFAULT 0 NULL,
    CONSTRAINT PK_DimExposure PRIMARY KEY CLUSTERED (Exposure_SK)
)
go



