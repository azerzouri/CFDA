TRUNCATE TABLE [wrk].[pipeline_parameter]
GO
INSERT INTO [wrk].[pipeline_parameter]
([Table_Name],
 [TABLE_CATALOG],
 [process_type],
 [SQLtxt])
VALUES
('SapiensCLaimFeedCashflow', 'RS_ODS', 'CF_Ceded_History', 'rein.usp_Sapiens_CLaim_Feed_Cashflow')
,('CashFlowEntryRawHistory', 'RS_ODS', 'CF_Ceded_History', 'rein.usp_CashFlowEntryRawHistory')
,('CashFlowEntryTransformHistory', 'RS_ODS', 'CF_Ceded_History', 'rein.usp_CashFlowEntryTransformHistory')
,('CashFlowEntryConformHistory', 'RS_ODS', 'CF_Ceded_History', 'rein.usp_CashFlowEntryConformHistory')
,('CashFlowEntryRaw', 'RS_ODS', 'CF_Ceded_History', 'rein.usp_CashFlowEntryRaw')
,('CashFlowEntryTransform', 'RS_ODS', 'CF_Ceded_History', 'rein.usp_CashFlowEntryTransform')
,('CashFlowEntryConform', 'RS_ODS', 'CF_Ceded_History', 'rein.usp_CashFlowEntryConform')
,('CededFinancialTransaction', 'RS_ODS', 'CF_Ceded_History', 'rein.usp_Ceded_Financial_Transaction')
go