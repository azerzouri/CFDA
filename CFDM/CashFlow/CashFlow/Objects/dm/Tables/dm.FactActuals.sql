/* 
 * TABLE: dm.FactActuals 
 */

CREATE TABLE dm.FactActuals(
    factActualsID                 int               IDENTITY(0,1),
    policy_SK                     int               NOT NULL,
    policyEffectiveDate_SK        int               NOT NULL,
    policyExpirationDate_SK       int               NOT NULL,
    policyCoverage_SK             int               NOT NULL,
    reinsurane_SK                 int               NOT NULL,
    adjuster_SK                   int               NOT NULL,
    claim_SK                      int               NOT NULL,
    Exposure_SK                   int               NOT NULL,
    exposureClosedDate_SK         int               NOT NULL,
    exposureOpenDate_SK           int               NOT NULL,
    exposureReopenDate_SK         int               NOT NULL,
    workMatter_SK                 int               NOT NULL,
    workmatterOpenDate_SK         int               NOT NULL,
    workmatterClosedDate_SK       int               NOT NULL,
    workmatterReopenDate_SK       int               NOT NULL,
    valuationDate_SK              int               NOT NULL,
    caseAdjustingExpense          decimal(14, 2)    NULL,
    caseCoverageDJExpense         decimal(14, 2)    NULL,
    caseLoss                      decimal(14, 2)    NULL,
    paidAdjustingExpense          decimal(14, 2)    NULL,
    paidCoverageDJExpense         decimal(14, 2)    NULL,
    paidExpenseInLimits           decimal(14, 2)    NULL,
    paidLoss                      decimal(14, 2)    NULL,
    recoveryDeductibleLoss        decimal(14, 2)    NULL,
    recoverySalvage               decimal(14, 2)    NULL,
    recoverySubrogationExpense    decimal(14, 2)    NULL,
    recoverySubrogationLoss       decimal(14, 2)    NULL,
    totalCase                     decimal(14, 2)    NULL,
    totalPaid                     decimal(14, 2)    NULL,
    totalPaidDefExpense           decimal(14, 2)    NULL,
    totalPaidLossExInLimits       decimal(14, 2)    NULL,
    audit_Insert_Dt               datetime          DEFAULT (getdate()) NULL,
    audit_Update_Dt               datetime          DEFAULT (getdate()) NULL,
    ins_Proc_ID                   int               NULL,
    upd_Proc_ID                   int               NULL,
    is_Deleted                    bit               DEFAULT 0 NULL,
    is_Active                     bit               DEFAULT 0 NULL,
    CONSTRAINT PK_FactActuals PRIMARY KEY CLUSTERED (factActualsID)
)
go



