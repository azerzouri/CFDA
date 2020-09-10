CREATE PROCEDURE [dm].[usp_DimReinsurance] AS
/*
 Procedure Name:  [dm].[usp_DimReinsurance]
 Purpose: To load Reinsurance data from staging 
 Called by: DF
 Calls: none
 Database: CashFlow_DM (DEV, QA and PRD)
 Date: 05/22/2020
 Author: Ragulan Vithurpan
 Change Log:
 Date		By		Reason			
 validation
 ************************************************************************************************************
 exec [dm].[usp_DimReinsurance]
 ************************************************************************************************************
 */
SET
  NOCOUNT ON;

BEGIN TRY DECLARE @InsertDate DATETIME = GETDATE() -- Catching executiontime
DECLARE @Ins_proc_id INT = 7 --- Insert the NA value SK
SET
  IDENTITY_INSERT [dm].[DimReinsurance] ON
INSERT INTO
    [dm].[DimReinsurance](
    [reinsurance_SK],
    [reinsurerName],
    [sapiensReinsurerID],
    [brokerName],
    [sapiensBrokerID],
    [sapiensPoolID],
    [sapiensBatchID],
	[sectionReferenceNumber],
	[poolName],
	[retentionInd],
    [audit_Insert_Dt],
    [audit_Update_Dt],
    [ins_Proc_ID],
    [upd_Proc_ID],
    [is_Deleted],
    [is_Active]
  )
VALUES
  (
    0,
    'NA',
    0,
    'NA',
    0,
    0,
    'NA',
	'NA',
	'NA',
	NULL,
    @InsertDate,
    NULL,
    @Ins_proc_id,
    NULL,
    0,
    1
  )
SET
  IDENTITY_INSERT [dm].[DimReinsurance] OFF -- Load the data from stg to datamart
INSERT INTO
  [dm].[DimReinsurance](
    [reinsurerName],
    [sapiensReinsurerID],
    [brokerName],
    [sapiensBrokerID],
    [sapiensPoolID],
    [sapiensBatchID],
    [sectionReferenceNumber],
	[poolName],
	[retentionInd],
    [audit_Insert_Dt],
    [audit_Update_Dt],
    [ins_Proc_ID],
    [upd_Proc_ID],
    [is_Deleted],
    [is_Active]
  )
SELECT
  DISTINCT
    [reinsurerName],
    [sapiensReinsurerID],
    [brokerName],
    [sapiensBrokerID],
    [sapiensPoolID],
    NULL AS [sapiensBatchID],
	[sectionReferenceNumber],
	[pool_Name],
	[retentionInd],
	@InsertDate,
    NULL,
    @Ins_proc_id,
    NULL,
    0 AS [Is_deleted],
    1 AS [Is_active]
FROM
  [stg].[Reinsurance]
END TRY 
BEGIN CATCH 
DECLARE @ErrorMessage NVARCHAR(2000) = ERROR_MESSAGE();
--Raise error
RAISERROR(@ErrorMessage, 16, 1);

INSERT INTO
  dm.Errors_log(
    RunId,
    BatchId,
    UserName,
    ErrorNumber,
    ErrorState,
    ErrorSeverity,
    ErrorLine,
    ErrorProcedure,
    ErrorMessage,
    ErrorDateTime
  )
VALUES
  (
    0,
    0,
    SUSER_SNAME(),
    ERROR_NUMBER(),
    ERROR_STATE(),
    ERROR_SEVERITY(),
    ERROR_LINE(),
    ERROR_PROCEDURE(),
    ERROR_MESSAGE(),
    GETDATE()
  );

END CATCH;