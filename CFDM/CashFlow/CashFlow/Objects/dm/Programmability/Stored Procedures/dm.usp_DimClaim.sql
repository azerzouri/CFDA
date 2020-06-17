CREATE PROCEDURE [dm].[usp_DimClaim] AS
    /*
     Procedure Name:  [dm].[usp_DimClaim]
     Purpose: To load claim data from staging 
     Called by: DF
     Calls: none
     Database: CashFlow_DM (DEV, QA and PRD)
     Date: 05/19/2020
     Author: Ragulan Vithurpan
     Change Log:
     Date		By		Reason			
     validation
     ************************************************************************************************************
     exec [dm].[usp_DimClaim]
     ************************************************************************************************************
     */
SET
    NOCOUNT ON;

BEGIN TRY DECLARE @InsertDate DATETIME = GETDATE() -- Catching executiontime
DECLARE @Ins_proc_id INT = 4 --- Insert the NA value SK
SET
    IDENTITY_INSERT [dm].[DimClaim] ON
INSERT INTO
    [dm].[DimClaim] (
        [claim_SK],
        [claimNo],
        [actuarialSegment],
        [fairfaxSegment],
        [claimSegment],
        [HandlingSegment],
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
        @InsertDate,
        NULL,
        @Ins_proc_id,
        NULL,
        0,
        1
    )
SET
    IDENTITY_INSERT [dm].[DimClaim] OFF -- Load the data from stg to datamart
;

with claimCTE AS(
    SELECT
        DISTINCT claimNumber
    FROM
        [stg].[FactActuals]
    UNION
    SELECT
        DISTINCT (
            SUBSTRING (
                claim_Exposure_No,
                0,
                CHARINDEX('-', claim_Exposure_No)
            )
        ) claimno
    FROM
        [stg].[FactCashflow]
)
INSERT INTO
    [dm].[DimClaim] (
        [claimNo],
        [actuarialSegment],
        [fairfaxSegment],
        [claimSegment],
        [HandlingSegment],
        [audit_Insert_Dt],
        [audit_Update_Dt],
        [ins_Proc_ID],
        [upd_Proc_ID],
        [is_Deleted],
        [is_Active]
    )
Select
    distinct C.claimNumber,
    CS.actuarialSegment,
    CS.fairfaxSegment,
    CS.[ClaimsSegment],
    CS.[HandlingSegment],
    @InsertDate,
    NULL,
    @Ins_proc_id,
    NULL,
    0 AS [Is_deleted],
    1 AS [Is_active]
from
    claimCTE C
    left Join [stg].[claimSegmentation] CS on C.claimNumber = CS.claimNumber
END TRY BEGIN CATCH DECLARE @ErrorMessage NVARCHAR(2000) = ERROR_MESSAGE();

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