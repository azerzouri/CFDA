CREATE TABLE stg.FactCashflow(
    factCashflow_ID                   int               IDENTITY(1,1),
    claim_Exposure_No                 varchar(64)       NOT NULL,
    workmatternumber                  varchar(64)       NOT NULL,
    cashFlowEntryPeriod               date              NULL,
    cashflowProjectionsfor            date              NULL,
    projectedPaidLossExInLimits       decimal(14, 2)    NULL,
    projectedPaidCoverageDJExpense    decimal(14, 2)    NULL,
    projectedTotalPaidDefExpense      decimal(14, 2)    NULL,
	claimNumber                       AS                SUBSTRING(claim_Exposure_No,0,CHARINDEX('-', claim_Exposure_No)) PERSISTED,
	FactCashFlowHashKey               AS                CONVERT(VARCHAR(32), HashBytes('MD5', CONCAT([claim_Exposure_No], ' ', [workmatternumber], ' ',	CAST([cashFlowEntryPeriod] AS VARCHAR), ' ',CAST([cashflowProjectionsfor] AS VARCHAR), ' ',	CAST([projectedPaidLossExInLimits] AS VARCHAR), ' ',CAST([projectedPaidCoverageDJExpense] AS VARCHAR), ' ',	CAST([projectedTotalPaidDefExpense] AS VARCHAR))),2),
    Insert_Date                       datetime          DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_stg_factcashflow PRIMARY KEY CLUSTERED (factcashflow_ID)
)
