CREATE TABLE stg.FactCashflow(
	[factCashflow_ID] [int] IDENTITY(1,1) NOT NULL,
	[claimExposureNo] [varchar](64) NOT NULL,
	[workMatterNumber] [varchar](64) NOT NULL,
	[cashFlowEntryPeriod] [date] NULL,
	[cashFlowProjectionsfFor] [date] NULL,
	[projectedPaidLossExInLimits] [decimal](14, 2) NULL,
	[projectedPaidCoverageDJExpense] [decimal](14, 2) NULL,
	[projectedTotalPaidDefExpense] [decimal](14, 2) NULL,
	[claimNumber]  AS (substring([claimExposureNo],(0),charindex('-',[claimExposureNo]))) PERSISTED,
	[Insert_Date] [datetime] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT PK_stg_factcashflow PRIMARY KEY CLUSTERED (factcashflow_ID)
)
