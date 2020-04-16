/* 
 * TABLE: stg.Notification 
 */

CREATE TABLE stg.Notification(
    notification_ID     int               IDENTITY(1,1),
    workMatterNumber    varchar(64)       NOT NULL,
    status              varchar(64)       NULL,
    comments            varchar(4000)     NULL,
    Confidence          varchar(64)       NULL,
    RWCLoss             decimal(14, 2)    NULL,
    RWCDefExp           decimal(14, 2)    NULL,
    RWCCovDJ            decimal(14, 2)    NULL,
    Insert_Date         datetime          DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_Notification PRIMARY KEY CLUSTERED (notification_ID)
)
go



