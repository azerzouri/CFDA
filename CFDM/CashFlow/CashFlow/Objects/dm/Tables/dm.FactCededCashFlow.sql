﻿CREATE TABLE [dm].[FactCededCashFlow]
(
	factCededCashflowID                      int               IDENTITY(0,1),
    policy_SK                                int               NOT NULL,
    policyEffectiveDate_SK                   int               NOT NULL,
    policyExpirationDate_SK                  int               NOT NULL,
    reinsurane_SK                            int               NOT NULL,
    adjuster_SK                              int               NOT NULL,
    claim_SK                                 int               NOT NULL,
    Exposure_SK                              int               NOT NULL,
    workMatter_SK                            int               NOT NULL,
    workmatterOpenDate_SK                    int               NOT NULL,
    workmatterClosedDate_SK                  int               NOT NULL,
    workmatterReopenDate_SK                  int               NOT NULL,
    valuationDate_SK                         int               NOT NULL,
    exposerReopenDate_SK                     int               NOT NULL,
    exposureClosedDate_SK                    int               NOT NULL,
    exposureOpenDate_SK                      int               NOT NULL,
    entryDate_SK                             int               NOT NULL,
    relatedClaimNumber                       varchar(50)       NULL,
    cededProjectedTotalPaid                  AS                 projectedCededTotalPaidDefExpense+projectedCededPaidCoverageDJExpense+projectedCededTotalPaidLossExInLimits PERSISTED,
    projectedCededPaidCoverageDJExpense      decimal(14, 2)    NULL,
    projectedCededTotalPaidDefExpense        decimal(14, 2)    NULL,
    projectedCededTotalPaidLossExInLimits    decimal(14, 2)    NULL,
    reasonableWorstCase                      decimal(14, 2)    NULL,
    rwcCovDJ                                 decimal(14, 2)    NULL,
    rwcDefExp                                decimal(14, 2)    NULL,
    rwcLossExInLimits                        decimal(14, 2)    NULL,
    creditProvisionPercent                   decimal(14, 2)    NULL,
    audit_Insert_Dt                          datetime          DEFAULT (getdate()) NULL,
    audit_Update_Dt                          datetime          DEFAULT (getdate()) NULL,
    ins_Proc_ID                              int               NULL,
    upd_Proc_ID                              int               NULL,
    is_Deleted                               bit               DEFAULT 0 NULL,
    is_Active                                bit               DEFAULT 0 NULL,
    CONSTRAINT PK_FactCashFlow_1 PRIMARY KEY CLUSTERED (factCededCashflowID)
)