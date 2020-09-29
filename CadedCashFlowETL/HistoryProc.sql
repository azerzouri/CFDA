--------------------Creating Proc for loading historial data to the Azure data lake
IF OBJECT_ID('rein.usp_Sapiens_CLaim_Feed_Cashflow') IS NOT NULL EXEC(
    '
DROP PROCEDURE rein.usp_CashFlowEntryRawHistory;
DROP PROCEDURE rein.usp_Sapiens_CLaim_Feed_Cashflow;
DROP PROCEDURE rein.usp_CashFlowEntryTransformHistory;
DROP PROCEDURE rein.usp_CashFlowEntryConformHistory;
DROP PROCEDURE rein.usp_CashFlowEntryRaw;
DROP PROCEDURE rein.usp_CashFlowEntryConform;
DROP PROCEDURE rein.usp_Ceded_Financial_Transaction;
DROP PROCEDURE rein.usp_CashFlowEntryTransform;
'
)
GO
    CREATE PROCEDURE rein.usp_Sapiens_CLaim_Feed_Cashflow AS -- =============================================
    -- Author:		Aziz
    -- Create date: 09/25/2020
    -- Description:	Just a proc to select historical data to dump it in Azure.
    -- =============================================
    BEGIN
SET
    NOCOUNT ON;

declare @rundate datetime
Set
    @rundate = GETDATE()
select
    @rundate AS PartitionKey,
    NEWID() AS RowKey,
    [SCFID],
    [Policy_No],
    [Policy_Eff_Dt],
    [Portfolio_Cd],
    [Product_Cd],
    [NAIC_Cd],
    [Risk_Unit_ID],
    [Policy_Period_ID],
    [PolicyVersion],
    [Policy_Coverage_Line_ID],
    [Sapiens_Claim_No],
    [Sapiens_Prior_Claim_No],
    [Related_Claim_No],
    [Exposure_No],
    [Transaction_ID],
    [Transaction_Cd],
    cast([Transaction_Amnt] AS float) AS [Transaction_Amnt],
    [Transaction_Dt],
    [Loss_Dt],
    [Claim_Report_Dt],
    [WorkMatter_No],
    [WM_Type_Cd],
    [Account_Name],
    [WorkMatter_Desc],
    [WorkMatter_Status_Cd],
    [WM_Special_Tracking_Group_Desc],
    [WorkMatter_Open_Dt],
    [WorkMatter_Close_Dt],
    [WorkMatter_Reopen_Dt],
    [Claimant_Name],
    [Claim_Status_Cd],
    [Claim_Open_Dt],
    [Claim_Close_Dt],
    [Claim_Reopen_Dt],
    [Accident_State_Cd],
    [Nature_of_Injury_cd],
    [Part_Of_Body_Cd],
    [Type_Of_Loss_Cd],
    [Manual_Session_Ind],
    [Migration_Ind],
    [CAT_Cd],
    [Sys_Create_Dt]
from
    rein.Sapiens_CLaim_Feed_Cashflow with (nolock)
END
GO
    CREATE PROCEDURE rein.usp_CashFlowEntryRawHistory AS -- =============================================
    -- Author:		Aziz
    -- Create date: 09/25/2020
    -- Description:	Just a proc to select historical data to dump it in Azure.
    -- =============================================
    BEGIN
SET
    NOCOUNT ON;

declare @rundate datetime
Set
    @rundate = GETDATE()
select
    @rundate AS PartitionKey,
    NEWID() AS RowKey,
    [CashFlowEntryRawHistoryID],
    [CashFlowEntryRawID],
    [DataSourceTypeID],
    [BatchID],
    [WorkMatter],
    [Exposure],
    [PolicyNumber],
    [Year],
    [Quarter],
    [ValueName],
    CAST([Amount] AS float) AS [Amount],
    [StartUser],
    [StartTime],
    [EndUser],
    [EndTime],
    [ProjectionPeriod],
    [SourceFileFullPath],
    [ArchiveFileFullPath],
    [CreatedDate],
    [CreatedBy],
    [ModifiedDate],
    [ModifiedBy],
    CAST([ProcessedStatusID] AS int) AS [ProcessedStatusID],
    CAST([BatchStatusID] AS int) AS [ProcessedStatusID],
    [HistoryCreatedBy],
    [HistoryCreatedDate]
from
    rein.CashFlowEntryRawHistory with (nolock)
END
GO
    CREATE PROCEDURE rein.usp_CashFlowEntryTransformHistory AS -- =============================================
    -- Author:		Aziz
    -- Create date: 09/25/2020
    -- Description:	Just a proc to select historical data to dump it in Azure.
    -- =============================================
    BEGIN
SET
    NOCOUNT ON;

declare @rundate datetime
Set
    @rundate = GETDATE()
select
    @rundate AS PartitionKey,
    NEWID() AS RowKey,
    [CashFlowEntryRawHistoryID],
    [CashFlowEntryTransformID],
    [CashFlowEntryRawID],
    [BatchID],
    [Claim_No],
    [Exposure_no],
    [Transaction_Cd],
    CAST([Amount] AS float) AS [Amount],
    [CreatedDate],
    [CreatedBy],
    [ModifiedDate],
    [ModifiedBy],
    CAST([ProcessedStatusID] AS int) AS [ProcessedStatusID],
    CAST([BatchStatusID] AS int) AS [ProcessedStatusID],
    [HistoryCreatedBy],
    [HistoryCreatedDate]
from
    rein.CashFlowEntryTransformHistory with (nolock)
END
GO
    CREATE PROCEDURE rein.usp_CashFlowEntryConformHistory AS -- =============================================
    -- Author:		Aziz
    -- Create date: 09/25/2020
    -- Description:	Just a proc to select historical data to dump it in Azure.
    -- =============================================
    BEGIN
SET
    NOCOUNT ON;

declare @rundate datetime
Set
    @rundate = GETDATE()
select
    @rundate AS PartitionKey,
    NEWID() AS RowKey,
    [CashFlowEntryRawHistoryID],
    [CashFlowEntryConformID],
    [BatchID],
    [Claim_No],
    [Exposure_no],
    [Transaction_Cd],
    CAST([Amount] AS float) AS [Amount],
    [CreatedDate],
    [CreatedBy],
    [ModifiedDate],
    [ModifiedBy],
    CAST([ProcessedStatusID] AS int) AS [ProcessedStatusID],
    CAST([BatchStatusID] AS int) AS [ProcessedStatusID],
    [HistoryCreatedBy],
    [HistoryCreatedDate]
from
    rein.CashFlowEntryConformHistory with (nolock)
END
GO
    CREATE PROCEDURE rein.usp_CashFlowEntryRaw AS -- =============================================
    -- Author:		Aziz
    -- Create date: 09/25/2020
    -- Description:	Just a proc to select historical data to dump it in Azure.
    -- =============================================
    BEGIN
SET
    NOCOUNT ON;

declare @rundate datetime
Set
    @rundate = GETDATE()
select
    @rundate AS PartitionKey,
    NEWID() AS RowKey,
    [CashFlowEntryRawID],
    CAST([DataSourceTypeID] AS int) AS [DataSourceTypeID],
    [BatchID],
    [WorkMatter],
    [Exposure],
    [PolicyNumber],
    [Year],
    [Quarter],
    [ValueName],
    CAST([Amount] AS float) AS [Amount],
    [StartUser],
    [StartTime],
    [EndUser],
    [EndTime],
    [ProjectionPeriod],
    [SourceFileFullPath],
    [ArchiveFileFullPath],
    [CreatedDate],
    [CreatedBy],
    [ModifiedDate],
    [ModifiedBy],
    CAST([ProcessedStatusID] AS int) AS [ProcessedStatusID],
    CAST([BatchStatusID] AS int) AS [BatchStatusID]
from
    rein.CashFlowEntryRaw with (nolock)
END
GO
    CREATE PROCEDURE rein.usp_CashFlowEntryTransform AS -- =============================================
    -- Author:		Aziz
    -- Create date: 09/25/2020
    -- Description:	Just a proc to select historical data to dump it in Azure.
    -- =============================================
    BEGIN
SET
    NOCOUNT ON;

declare @rundate datetime
Set
    @rundate = GETDATE()
select
    @rundate AS PartitionKey,
    NEWID() AS RowKey,
    [CashFlowEntryTransformID],
    [CashFlowEntryRawID],
    [BatchID],
    [Claim_No],
    [Exposure_no],
    [Transaction_Cd],
    CAST([Amount] AS float) AS [Amount],
    [CreatedDate],
    [CreatedBy],
    [ModifiedDate],
    [ModifiedBy],
    CAST([ProcessedStatusID] AS int) AS [ProcessedStatusID],
    CAST([BatchStatusID] AS int) AS [ProcessedStatusID]
from
    rein.CashFlowEntryTransform with (nolock)
END
GO
    CREATE PROCEDURE rein.usp_CashFlowEntryConform AS -- =============================================
    -- Author:		Aziz
    -- Create date: 09/25/2020
    -- Description:	Just a proc to select historical data to dump it in Azure.
    -- =============================================
    BEGIN
SET
    NOCOUNT ON;

declare @rundate datetime
Set
    @rundate = GETDATE()
select
    @rundate AS PartitionKey,
    NEWID() AS RowKey,
    [CashFlowEntryConformID],
    [BatchID],
    [Claim_No],
    [Exposure_no],
    [Transaction_Cd],
    CAST([Amount] AS float) AS [Amount],
    [CreatedDate],
    [CreatedBy],
    [ModifiedDate],
    [ModifiedBy],
    CAST([ProcessedStatusID] AS int) AS [ProcessedStatusID],
    CAST([BatchStatusID] AS int) AS [ProcessedStatusID]
from
    rein.CashFlowEntryConform with (nolock)
END
GO
    CREATE PROCEDURE rein.usp_Ceded_Financial_Transaction AS -- =============================================
    -- Author:		Aziz
    -- Create date: 09/25/2020
    -- Description:	Just a proc to select historical data to dump it in Azure.
    -- =============================================
    BEGIN
SET
    NOCOUNT ON;

declare @rundate datetime
Set
    @rundate = GETDATE()
select
    @rundate AS PartitionKey,
    NEWID() AS RowKey,
    [Transaction_Id],
    [GlassBox_Rule_ID],
    [Original_System_Source_Cd],
    [Original_Business_Type_Cd],
    [Transaction_Source_Cd],
    [Business_Type_Cd],
    [Reporting_Entity_Cd],
    [Portfolio_Cd],
    [ExposureSK],
    [Exposure_Id],
    [Payment_Method_CD],
    [Original_Transaction_Dt],
    [Transaction_Dt],
    [Transaction_Category_Cd],
    [Transaction_Type_CD],
    [Transaction_Detail_CD],
    [WC_Payment_Type_ID],
    [WC_Payment_Kind_Cd],
    [WC_Provider_Type_Cd],
    [WC_Capacity_Type_Cd],
    [Service_From_Date],
    [Service_To_Date],
    [Case_Reserve_Type],
    [Case_Reserve_Status],
    CAST([Paid_Loss] AS float) AS [Paid_Loss],
    CAST([Paid_Adjusting_Expense_InLimits] AS float) AS [Paid_Adjusting_Expense_InLimits],
    CAST([Paid_Coverage_DJ_Expense] AS float) AS [Paid_Coverage_DJ_Expense],
    CAST([Paid_Adjusting_Expense] AS float) AS [Paid_Adjusting_Expense],
    CAST([Recovery_Salavage] AS float) AS [Recovery_Salavage],
    CAST([Recovery_Deductible_Loss] AS float) AS [Recovery_Salavage],
    CAST([Recovery_Subrogation_Expense] AS float) AS [Recovery_Subrogation_Expense],
    CAST([Recovery_Subrogation_Loss] AS float) AS [Recovery_Subrogation_Loss],
    CAST([Case_Coverage_DJ_Expense] AS float) AS [Case_Coverage_DJ_Expense],
    CAST([Case_Adjusting_Expense] AS float) AS [Case_Adjusting_Expense],
    CAST([Case_Loss] AS float) AS [Case_Loss],
    CAST([Recoverable_Deductible] AS float) AS [Recoverable_Deductible],
    CAST([Recoverable_NonDeductible] AS float) AS [Recoverable_NonDeductible],
    [Foreign_Currency_Type],
    CAST([Foreign_Currency_Amount] AS float) AS [Foreign_Currency_Amount],
    [Vendor_ID],
    [Payee_desc],
    [Payor_desc],
    [External_Check_No],
    [Address_Site_No],
    CAST([Lag_Ind] AS int) AS [Lag_Ind],
    [Lag_Valuation_Dt],
    [Original_Valuation_Date],
    [Valuation_Dt],
    [Payment_Offset_ID],
    [Affiliate_Ind],
    [Erodes_Reserve_Ind],
    [Reallocation_Ind],
    [Migration_Ind],
    [Cedant_ID],
    [Contract_Participant_ID],
    [Reins_Contract_ID],
    [Reinsurer_Id],
    [MasterFileSeq],
    [SourceSeqNum],
    [SourceID],
    [CalculationDate],
    [ProcessDate],
    [ContractNo],
    [AdditionalContractNo],
    [AdditionalSectionNo],
    [ContractID],
    [SectionNo],
    [ContractLayerID],
    [PartipantID],
    CAST([ParticipantShare] AS float) AS [ParticipantShare],
    CAST([CedentPartShare] AS float) AS [CedentPartShare],
    [SecontRefNo],
    [MSContractSeq],
    [MSReinsurerSeq],
    [BlockSeq],
    [CommutedID],
    CAST([CommutedPercent] AS float) AS [CommutedPercent],
    [SrcReinsur_ID],
    [ReinsurerID],
    [SrcBrokerID],
    [BrokerID],
    [SrcPoolID],
    [PoolID],
    [PoolVersion],
    [RetentionInd],
    [AcctingItem],
    CAST([CalculatedAmt] AS float) AS [CalculatedAmt],
    CAST([OriginalAcctingAmt] AS float) AS [OriginalAcctingAmt],
    CAST([ContractShare] AS float) AS [ContractShare],
    CAST([ReinsurerShare] AS float) AS [ReinsurerShare],
    [DebitCredit],
    [CompanyCode],
    [DataSource],
    [Policy],
    [PolicyEffDt],
    [DocumentType],
    [RecordInd],
    [ClaimNo],
    [ExposureNo],
    [CashFlowBatchID]
from
    trn.Ceded_Financial_Transaction with (nolock)
END
GO