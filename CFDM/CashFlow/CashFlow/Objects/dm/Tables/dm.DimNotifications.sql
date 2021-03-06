/* 
 * TABLE: dm.DimNotifications 
 */

CREATE TABLE dm.DimNotifications(
    notification_SK						 int              IDENTITY(1,1),
    workMatterNo						 varchar(64)      NOT NULL,
    Comments							 varchar(4000)    NULL,
    fiscalYearConfidenceRating			 varchar(64)      NULL,
	remainingConfidenceRating			 varchar(64)      NULL,
	insuredLocation						 varchar(2)       NULL,
    [Status]						     varchar(64)      NULL,
    [RWCLoss]                            [decimal](14, 2) NULL,
	[RWCDefExp]                          [decimal](14, 2) NULL,
	[RWCCovDJ]                           [decimal](14, 2) NULL,
    audit_Insert_Dt						 datetime         DEFAULT (getdate()) NULL,
    audit_Update_Dt						 datetime         DEFAULT (getdate()) NULL,
    ins_Proc_ID							 int              NULL,
    upd_Proc_ID						     int              NULL,
    is_Deleted							 bit              DEFAULT 0 NULL,
    is_Active							 bit              DEFAULT 0 NULL,
    CONSTRAINT PK_DimNotifications PRIMARY KEY CLUSTERED (notification_SK)
)
go



