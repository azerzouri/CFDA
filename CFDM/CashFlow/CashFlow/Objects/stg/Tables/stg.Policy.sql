/* 
 * TABLE: stg.Policy 
 */

CREATE TABLE stg.Policy(
    policy_ID               int            IDENTITY(1,1),
    policy_No               varchar(64)    NOT NULL,
    portfolio_Cd            varchar(64)    NULL,
	NAICCode                varchar(12)    NULL,
    businessTypeCode        char(1)        NULL,
    policyEffectiveDate     date           NULL,
    policyExpirationDate    date           NULL,
    Insert_Date             datetime       DEFAULT getdate() NOT NULL,
    CONSTRAINT PK_Policy PRIMARY KEY CLUSTERED (policy_ID)
)
go



