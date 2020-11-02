CREATE PROCEDURE [dm].[usp_DimNotification] AS
/*
 Procedure Name:  [dm].[usp_DimNotification]
 Purpose: To load Notification data from staging 
 Called by: DF
 Calls: none
 Database: CashFlow_DM (DEV, QA and PRD)
 Date: 05/18/2020
 Author: Ragulan Vithurpan
 Change Log:
 Date		By		Reason			
 validation
 ************************************************************************************************************
 exec [dm].[usp_DimNotification]
 ************************************************************************************************************
 */
SET
    NOCOUNT ON;

BEGIN TRY DECLARE @InsertDate DATETIME = GETDATE() -- Catching executiontime
DECLARE @Ins_proc_id INT = 3 --- Insert the NA value SK
SET
    IDENTITY_INSERT [dm].[DimNotifications] ON
INSERT INTO
    [dm].[DimNotifications] (
        [notification_SK],
        [workMatterNo],
        [Comments],
        [fiscalYearConfidencerating],
		[remainingConfidencerating],
		[insuredLocation],
        [Status],
		[RWCLoss],                           
		[RWCDefExp],                         
		[RWCCovDJ],
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
        'NA',
		'NA',
        'NA',
        'NA',
        'NA',
		0.00,
		0.00,
		0.00,
        @InsertDate,
        NULL,
        @Ins_proc_id,
        NULL,
        0,
        1
    )
SET
    IDENTITY_INSERT [dm].[DimNotifications] OFF -- Load the data from stg to datamart
INSERT INTO
    [dm].[DimNotifications](
        [workMatterNo],
        [Comments],
        [fiscalYearConfidencerating],
		[remainingConfidencerating],
		[insuredLocation],
        [Status],
		[RWCLoss],                           
		[RWCDefExp],                         
		[RWCCovDJ],      
        [audit_Insert_Dt],
        [audit_Update_Dt],
        [ins_Proc_ID],
        [upd_Proc_ID],
        [is_Deleted],
        [is_Active]
    )
SELECT
    DISTINCT 
        [workmatternumber],
        [comments],
		[Confidence],
        [Confidence1],
		[insuredLocation],
        [status],
		[RWCLoss],                           
		[RWCDefExp],                         
		[RWCCovDJ],      
        @InsertDate,
        NULL,
        @Ins_proc_id,
        NULL,
        0 AS [Is_deleted],
        1 AS [Is_active]
FROM
    [stg].[Notification]
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