/* 
 * TABLE: dm.DimClaim 
 */

CREATE TABLE dm.DimClaim(
    claim_SK            int            NOT NULL,
    claimNo             varchar(50)    NULL,
    actuarialSegment    varchar(50)    NULL,
    fairfaxSegment      varchar(50)    NULL,
    claimSegment        varchar(50)    NULL,
    audit_Insert_Dt     datetime       DEFAULT GetDate() NULL,
    audit_Update_Dt     datetime       DEFAULT GetDate() NULL,
    ins_Proc_ID         int            NULL,
    upd_Proc_ID         int            NULL,
    is_Deleted          bit            DEFAULT 0 NULL,
    is_Active           bit            DEFAULT 0 NULL,
    CONSTRAINT PK_DimClaim PRIMARY KEY CLUSTERED (claim_SK)
)
go



