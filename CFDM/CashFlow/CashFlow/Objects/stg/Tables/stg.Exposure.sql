/* 
 * TABLE: stg.Exposure 
 */

CREATE TABLE stg.Exposure(
    exposure_ID           int             IDENTITY(1,1),
    claim_Exposure_No     varchar(64)     NOT NULL,
    claimNumber           varchar(64)     NOT NULL,
    exposure_No           varchar(64)     NOT NULL,
    exposureStatus        varchar(64)     NULL,
    insuredName           varchar(512)    NULL,
    exposureOpenDate      date            NULL,
    exposureCloseDate     date            NULL,
    exposureReOpenDate    date            NULL,
    Insert_Date           datetime        DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_exposure PRIMARY KEY CLUSTERED (exposure_ID)
)
go



