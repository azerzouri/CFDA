/* 
 * TABLE: dm.FactCashFlow 
 */

CREATE TABLE dm.FactCashFlow(
    factCashflowID                    int               IDENTITY(0,1),
    notification_SK                   int               NOT NULL,
    policy_SK                         int               NOT NULL,
    policyEffectiveDate_SK            int               NOT NULL,
    policyExpirationDate_SK           int               NOT NULL,
    adjuster_SK                       int               NOT NULL,
    claim_SK                          int               NOT NULL,
    Exposure_SK                       int               NOT NULL,
    workMatter_SK                     int               NOT NULL,
    workMatterOpenDate_SK             int               NOT NULL,
    workMatterClosedDate_SK           int               NOT NULL,
    workMatterReopenDate_SK           int               NOT NULL,
    exposureReopenDate_SK             int               NOT NULL,
    exposureClosedDate_SK             int               NOT NULL,
    exposureOpenDate_SK               int               NOT NULL,
    entryDate_SK                      int               NOT NULL,
    projectionDate_SK                 int               NOT NULL,
    projectedPaidCoverageDJExpense    decimal(14, 2)    NULL,
    projectedPaidLossExInLimits       decimal(14, 2)    NULL,
    projectedTotalPaid                AS                ISNULL(projectedPaidLossExInLimits, 0) + ISNULL(projectedTotalPaidDefExpense, 0) + ISNULL(projectedPaidCoverageDJExpense, 0) PERSISTED,
    projectedTotalPaidDefExpense      decimal(14, 2)    NULL,
    audit_Insert_Dt                   datetime          DEFAULT (getdate()) NULL,
    audit_Update_Dt                   datetime          DEFAULT (getdate()) NULL,
    ins_Proc_ID                       int               NULL,
    upd_Proc_ID                       int               NULL,
    is_Deleted                        bit               DEFAULT 0 NULL,
    is_Active                         bit               DEFAULT 0 NULL,
    CONSTRAINT PK_FactCashFlow PRIMARY KEY CLUSTERED (factCashflowID)
)
go



