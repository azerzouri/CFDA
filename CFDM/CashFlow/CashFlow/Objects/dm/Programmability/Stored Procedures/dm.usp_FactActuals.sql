CREATE PROCEDURE [dm].[usp_FactActuals] AS
/*
 Procedure Name:  [dm].[usp_DmFactActuals]
 Purpose: Prepare data FROM Stage  to DM fact
 Called by: DF
 Calls: none
 DatabASe: CAShFlow_DM (DEV, QA AND PRD)
 Date: 05/28/2020
 Author: Ragulan Vithurpan
 Change Log:
 Date		By		ReASon			
 Validated
 ************************************************************************************************************
 exec [dm].[usp_DmFactActuals]
 ************************************************************************************************************
 */
SET
    NOCOUNT ON;

BEGIN TRY DECLARE @InsertDate DATETIME = GETDATE() -- Catching executiontime
DECLARE @Ins_proc_id INT = 8;

WITH AdjusterCTE AS (
    SELECT
        [adjustedName],
        [workmatternumber],
        MAX(COALESCE(NULL, [expirationDate], GETDATE())) AS expirationDate,
        ROW_NUMBER() OVER (
            PARTITION BY [workmatternumber]
            ORDER BY
                MAX(COALESCE(NULL, [expirationDate], GETDATE())) DESC
        ) AS rownum
    FROM
        [stg].[Adjuster]
    GROUP BY
        [adjustedName],
        [workmatternumber]
),
WMAdjusterCTE AS (
    SELECT
        DISTINCT [workmatternumber],
        [adjustedName]
    FROM
        AdjusterCTE
    WHERE
        rownum = 1
    UNION
    SELECT
        workmatternumber,
        'NA' AS [adjustedName]
    FROM
        [dm].[DimWorkmatter]
    where
        workmatternumber in (
            SELECT
                workmatternumber
            FROM
                stg.FactActuals
            EXCEPT
            SELECT
                [workmatternumber]
            FROM
                stg.Adjuster
        )
)
INSERT INTO
        [dm].[FactActuals](
        [policy_SK],
        [policyEffectiveDate_SK],
        [policyExpirationDate_SK],
        [adjuster_SK],
        [claim_SK],
        [Exposure_SK],
        [exposureClosedDate_SK],
        [exposureOpenDate_SK],
        [exposureReopenDate_SK],
        [workMatter_SK],
        [workmatterOpenDate_SK],
        [workmatterClosedDate_SK],
        [workmatterReopenDate_SK],
        [valuationDate_SK],
        [cASeAdjustingExpense],
        [cASeCoverageDJExpense],
        [cASeLoss],
        [paidAdjustingExpense],
        [paidCoverageDJExpense],
        [paidExpenseInLimits],
        [paidLoss],
        [recoveryDeductibleLoss],
        [recoverySalvage],
        [recoverySubrogationExpense],
        [recoverySubrogationLoss],
        [audit_Insert_Dt],
        [audit_Update_Dt],
        [ins_Proc_ID],
        [upd_Proc_ID],
        [is_Deleted],
        [is_Active]
    )
SELECT
        ISNULL(P.policy_SK, 0) AS Policy_SK,
        ISNULL(Dt1.Date_SK, 0) AS PolicyEffectiveDate_SK,
        ISNULL(Dt2.Date_SK, 0) AS PolicyExpirationDate_SK,
        ISNULL(DA.adjuster_SK, 0) AS Adjuster_SK,
        ISNULL(C.claim_SK, 0) AS claim_SK,
        ISNULL(e.exposure_SK, 0) AS Exposure_SK,
        ISNULL(Dt3.Date_SK, 0) AS ExposureClosedDate_SK,
        ISNULL(Dt4.Date_SK, 0) AS ExposureOpenDate_SK,
        ISNULL(Dt5.Date_SK, 0) AS ExposureReopenDate_SK,
        ISNULL(w.workMatter_SK, 0) AS Workmatter_SK,
        ISNULL(Dt6.Date_SK, 0) AS WorkmatterOpenDate_SK,
        ISNULL(Dt7.Date_SK, 0) AS WorkmatterClosedDate_SK,
        ISNULL(Dt8.Date_SK, 0) AS WorkmatterReopenDate_SK,
        ISNULL(Dt9.Date_SK, 0) AS valuationDate_SK,
        f.cASeAdjustingExpense,
        f.cASeCoverageDJExpense,
        f.cASeLoss,
        f.paidAdjustingExpense,
        f.paidCoverageDJExpense,
        f.paidexpenseinlimits,
        f.paidLoss,
        f.recoveryDeductibleLoss,
        f.recoverySalvage,
        f.recoverySubrogationExpense,
        f.recoverySubrogationLoss,
        @InsertDate AS [Audit_insert_dt],
        NULL AS [Audit_update_dt],
        @Ins_proc_id AS [Ins_proc_id],
        NULL AS [Upd_proc_id],
        0 AS [Is_deleted],
        1 AS [Is_active]
FROM
        stg.FactActuals F
        LEFT JOIN dm.DimClaim C ON F.claimNumber = c.claimNo
        LEFT JOIN dm.DimExposure e ON f.claim_Exposure_No = e.claimExposureNo
        LEFT JOIN stg.Exposure SE ON SE.claim_Exposure_No = F.claim_Exposure_No
        LEFT JOIN dm.DimWorkmatter w ON F.workmatternumber = w.workmatternumber
        LEFT JOIN stg.Workmatter SW ON SW.workmatternumber = F.workmatternumber
        LEFT JOIN dm.DimPolicy p ON f.policy_No = p.policyNumber
        AND f.portfolio_Cd = p.portfolioCode
        AND f.[NAIC_Cd] = p.NAICCode
        AND f.[Business_Type_Cd] = p.businessTypeCode
        LEFT JOIN WMAdjusterCTE A ON A.workmatternumber = F.workmatternumber
        LEFT JOIN dm.DimAdjuster DA ON A.adjustedName = DA.adjusterName
        LEFT JOIN [dm].[DimDate] Dt1 ON F.policyEffectiveDate = Dt1.datefull
        LEFT JOIN [dm].[DimDate] Dt2 ON F.Policy_Expiration_Dt = Dt2.datefull
        LEFT JOIN [dm].[DimDate] Dt3 ON SE.exposureCloseDate = Dt3.datefull
        LEFT JOIN [dm].[DimDate] Dt4 ON SE.exposureOpenDate = Dt4.datefull
        LEFT JOIN [dm].[DimDate] Dt5 ON SE.exposureReOpenDate = Dt5.datefull
        LEFT JOIN [dm].[DimDate] Dt6 ON SW.workmatterOpenDate = Dt6.datefull
        LEFT JOIN [dm].[DimDate] Dt7 ON SW.workmattercloseddate = Dt7.datefull
        LEFT JOIN [dm].[DimDate] Dt8 ON SW.workmatterreopendate = Dt8.datefull
        LEFT JOIN [dm].[DimDate] Dt9 ON F.valuationdate = Dt9.datefull
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