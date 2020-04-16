/* 
 * TABLE: stg.Workmatter 
 */

CREATE TABLE stg.Workmatter(
    workMatter_ID                int             IDENTITY(1,1),
    workMatterNumber             varchar(64)     NOT NULL,
    workMatterDescription        varchar(512)    NULL,
    workMatterTypeDescription    varchar(64)     NULL,
    workMatterStatus             varchar(64)     NULL,
    specialTrackingGroup         varchar(64)     NULL,
    account                      varchar(64)     NULL,
    workMatterOpenDate           date            NULL,
    workMatterReOpenDate         date            NULL,
    workMatterClosedDate         date            NULL,
    Insert_Date                  datetime        DEFAULT getdate() NOT NULL,
    CONSTRAINT PK_Workmatter PRIMARY KEY NONCLUSTERED (workMatter_ID)
)
go



