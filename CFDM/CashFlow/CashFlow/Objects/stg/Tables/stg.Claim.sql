CREATE TABLE stg.Claim(
    claim_ID            int            IDENTITY(1,1),
    claimNumber         varchar(64)    NOT NULL,
    actuarialSegment    varchar(64)    NULL,
    fairfaxSegment      varchar(64)    NULL,
    claimSegment        varchar(64)    NULL,
    Insert_Date         datetime       DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_claim PRIMARY KEY CLUSTERED (claim_ID)
)
