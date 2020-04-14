CREATE TABLE stg.Workmatter(
    workMatter_ID                int             IDENTITY(1,1),
    workmatternumber             varchar(64)     NOT NULL,
    workmatterDescription        varchar(512)    NULL,
    workmatterTypeDescription    varchar(64)     NULL,
    workmatterStatus             varchar(64)     NULL,
    specialtrackinggroup         varchar(64)     NULL,
    account                      varchar(64)     NULL,
    workmatterOpenDate           date            NULL,
    workmatterreopendate         date            NULL,
    workmattercloseddate         date            NULL,
    Insert_Date                  datetime        DEFAULT getdate() NOT NULL,
    CONSTRAINT PK_Workmatter PRIMARY KEY CLUSTERED (workMatter_ID)
)