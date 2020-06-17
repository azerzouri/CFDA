CREATE PROCEDURE [dm].[usp_FactCededCashflow] AS
/*
 Procedure Name:  [dm].[usp_FactCededCashflow]
 Purpose: Prepare data FROM Stage  to DM fact
 Called by: DF
 Calls: none
 DatabASe: CAShFlow_DM (DEV, QA AND PRD)
 Date: 06/01/2020
 Author: Ragulan Vithurpan
 Change Log:
 Date		By		ReASon			
 Validated
 ************************************************************************************************************
 exec [dm].[usp_FactCededCashflow]
 ************************************************************************************************************
 */
SET
    NOCOUNT ON;

BEGIN TRY DECLARE @InsertDate DATETIME = GETDATE() -- Catching executiontime
DECLARE @Ins_proc_id INT = 10;

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
WMAdjuster AS (
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
    WHERE
        workmatternumber IN (
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
),
Policynumber AS (
    SELECT
        DISTINCT R.claimNumber,
        R.exposure_No,
        fa.policy_No,
        fa.portfolio_Cd,
        fa.Business_Type_Cd,
        fa.NAIC_Cd,
        fa.policyEffectiveDate,
        fa.Policy_Expiration_Dt
    FROM
        [stg].[Reinsurance] R
        LEFT JOIN [stg].FactActuals fa ON R.claimNumber = fa.claimNumber
        AND R.exposure_No = fa.exposure_No
    WHERE
        R.CashFlowBatchID IS NOT NULL
),
WorkmatterNumber AS (
    SELECT
        DISTINCT R.claimNumber,
        R.exposure_No,
        f.workmatternumber
    FROM
        stg.Reinsurance R
        left join stg.FactActuals F ON F.claimNumber = R.claimNumber
        AND F.exposure_No = R.exposure_No
    WHERE
        R.CashFlowBatchID IS NOT NULL
)
INSERT INTO
    [dm].[FactCededCashFlow](
        [policy_SK],
        [policyEffectiveDate_SK],
        [policyExpirationDate_SK],
        [reinsurance_SK],
        [adjuster_SK],
        [claim_SK],
        [Exposure_SK],
        [workMatter_SK],
        [workmatterOpenDate_SK],
        [workmatterClosedDate_SK],
        [workmatterReopenDate_SK],
        [exposureReopenDate_SK],
        [exposureClosedDate_SK],
        [exposureOpenDate_SK],
        [entryDate_SK],
        [relatedClaimNumber],
        [projectedCededPaidCoverageDJExpense],
        [projectedCededTotalPaidDefExpense],
        [projectedCededTotalPaidLossExInLimits],
        [creditProvisionPercent],
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
    ISNULL(DR.reinsurane_SK, 0) AS Reinsurance_SK,
    ISNULL(DA.adjuster_SK, 0) AS Adjuster_SK,
    ISNULL(C.claim_SK, 0) AS claim_SK,
    ISNULL(e.exposure_SK, 0) AS Exposure_SK,
    ISNULL(w.workMatter_SK, 0) AS Workmatter_SK,
    ISNULL(Dt6.Date_SK, 0) AS WorkmatterOpenDate_SK,
    ISNULL(Dt7.Date_SK, 0) AS WorkmatterClosedDate_SK,
    ISNULL(Dt8.Date_SK, 0) AS WorkmatterReopenDate_SK,
    ISNULL(Dt5.Date_SK, 0) AS ExposureReopenDate_SK,
    ISNULL(Dt3.Date_SK, 0) AS ExposureClosedDate_SK,
    ISNULL(Dt4.Date_SK, 0) AS ExposureOpenDate_SK,
    ISNULL(Dt9.Date_SK, 0) AS EntryDate_SK,
    R.relatedClaimNumber,
    R.[projectedCededPaidCoverageDJExpense],
    R.[projectedCededTotalPaidDefExpense],
    R.[projectedCededTotalPaidLossExInLimits],
    R.creditProvisionPercent,
    @InsertDate AS [Audit_insert_dt],
    NULL AS [Audit_update_dt],
    @Ins_proc_id AS [Ins_proc_id],
    NULL AS [Upd_proc_id],
    0 AS [Is_deleted],
    1 AS [Is_active]
FROM
    [stg].[Reinsurance] R
    LEFT JOIN dm.DimClaim C ON R.claimNumber = C.claimNo
    LEFT JOIN dm.DimExposure e ON R.claimNumber = SUBSTRING(
        e.claimExposureNo,
        0,
        CHARINDEX('-', e.claimExposureNo)
    )
    AND RIGHT(e.claimExposureNo, 4) = R.exposure_No
    LEFT JOIN stg.Exposure SE ON SE.claimNumber = R.claimNumber
    AND SE.exposure_No = R.exposure_No
    LEFT JOIN WorkmatterNumber WN ON WN.claimNumber = R.claimNumber
    and wN.exposure_No = R.exposure_No
    LEFT JOIN dm.DimWorkmatter W ON w.workmatternumber = WN.workmatternumber
    LEFT JOIN Stg.Workmatter SW ON WN.workmatternumber = SW.workmatternumber
    LEFT JOIN Policynumber PA ON R.claimNumber = pa.claimNumber
    AND R.exposure_No = PA.exposure_No
    LEFT JOIN Dm.DimPolicy p ON pa.policy_No = p.policyNumber
    AND pa.portfolio_Cd = p.portfolioCode
    AND pa.[NAIC_Cd] = p.NAICCode
    AND pa.[Business_Type_Cd] = p.businessTypeCode
    LEFT JOIN dm.dimReinsurance DR ON COALESCE(DR.[reinsurerName], '') = COALESCE(R.reinsurerName, '')
    AND COALESCE(DR.sapiensReinsurerID, -9999) = COALESCE(R.sapiensReinsurerID, -9999)
    AND COALESCE(DR.brokerName, '') = COALESCE(R.brokerName, '')
    AND COALESCE(DR.sapiensBrokerID, -9999) = COALESCE(R.sapiensBrokerID, -9999)
    AND COALESCE(DR.sapiensPoolID, -9999) = COALESCE(R.sapiensPoolID, -9999)
    LEFT JOIN WMAdjuster A ON A.workmatternumber = WN.workmatternumber
    LEFT JOIN dm.DimAdjuster DA ON A.adjustedName = DA.adjusterName
    LEFT JOIN [dm].[DimDate] Dt1 ON pa.policyEffectiveDate = Dt1.datefull
    LEFT JOIN [dm].[DimDate] Dt2 ON pa.Policy_Expiration_Dt = Dt2.datefull
    LEFT JOIN [dm].[DimDate] Dt3 ON SE.exposureCloseDate = Dt3.datefull
    LEFT JOIN [dm].[DimDate] Dt4 ON SE.exposureOpenDate = Dt4.datefull
    LEFT JOIN [dm].[DimDate] Dt5 ON SE.exposureReOpenDate = Dt5.datefull
    LEFT JOIN [dm].[DimDate] Dt6 ON SW.workmatterOpenDate = Dt6.datefull
    LEFT JOIN [dm].[DimDate] Dt7 ON SW.workmattercloseddate = Dt7.datefull
    LEFT JOIN [dm].[DimDate] Dt8 ON SW.workmatterreopendate = Dt8.datefull
    LEFT JOIN [dm].[DimDate] Dt9 ON R.entrydate = Dt9.datefull
WHERE
    R.CashFlowBatchID IS NOT NULL
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