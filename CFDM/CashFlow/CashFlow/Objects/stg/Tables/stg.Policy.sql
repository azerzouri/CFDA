CREATE TABLE stg.Policy(
    policy_ID               int            IDENTITY(1,1),
    Policy_No               varchar(64)    NOT NULL,
    Portfolio_Cd            varchar(64)    NULL,
    Policy_Effective_Dt     date           NULL,
    Policy_Expiration_Dt    date           NULL,
    Insert_Date             datetime       DEFAULT getdate() NOT NULL,
    CONSTRAINT PK_Policy PRIMARY KEY CLUSTERED (policy_ID)
)