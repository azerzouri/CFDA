/* 
 * TABLE: stg.Adjuster 
 */

CREATE TABLE stg.Adjuster(
    adjuster_ID         int            IDENTITY(1,1),
    claimCenterID       int            NOT NULL,
    associateName       varchar(64)    NULL,
    adjustedName        varchar(64)    NULL,
    managerName         varchar(64)    NULL,
    groupManagerName    varchar(64)    NULL,
    department          varchar(64)    NULL,
    emailAddress        varchar(64)    NULL,
    userName            varchar(64)    NULL,
    effectiveDate       date           NULL,
    expirationDate      date           NULL,
    workmatternumber    varchar(64)    NULL,
    Insert_Date         datetime       DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_Adjuster PRIMARY KEY CLUSTERED (adjuster_ID)
)
go



