/* 
 * TABLE: dm.DimReinsurance 
 */

CREATE TABLE dm.DimReinsurance(
    reinsurane_SK             int             IDENTITY(0,1),
    reinsurerName             varchar(256)    NULL,
    sapiensReinsurerID        int             NULL,
    brokerName                varchar(50)     NULL,
    sapiensBrokerID           int             NULL,
    sapiensPoolID             int             NULL,
    sapiensBatchID            varchar(50)     NULL,
    sectionReferenceNumber    varchar(50)     NULL,
    audit_Insert_Dt           datetime        DEFAULT GetDate() NULL,
    audit_Update_Dt           datetime        DEFAULT GetDate() NULL,
    ins_Proc_ID               int             NULL,
    upd_Proc_ID               int             NULL,
    is_Deleted                bit             DEFAULT 0 NULL,
    is_Active                 bit             DEFAULT 0 NULL,
    CONSTRAINT PK_DimReinsurance PRIMARY KEY CLUSTERED (reinsurane_SK)
)
go



