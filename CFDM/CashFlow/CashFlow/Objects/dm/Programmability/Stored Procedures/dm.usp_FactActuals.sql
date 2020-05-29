CREATE PROCEDURE [dm].[usp_FactActuals]

AS
/*
 Procedure Name:  [dm].[usp_DmFactActuals]
 Purpose: Prepare data from Stage  to DM fact
 Called by: DF
 Calls: none
 Database: CashFlow_DM (DEV, QA and PRD)
 Date: 05/28/2020
 Author: Ragulan Vithurpan
 Change Log:
 Date		By		Reason			
 Validated
 ************************************************************************************************************
 exec [dm].[usp_DmFactActuals]
 ************************************************************************************************************
 */
SET
    NOCOUNT ON;

BEGIN TRY DECLARE @InsertDate DATETIME = GETDATE() -- Catching executiontime
DECLARE @Ins_proc_id INT = 8

;WITH Adjuster AS (
 SELECT	  
[adjustedName],
[workmatternumber],
MAX(COALESCE(NULL, [expirationDate], GETDATE())) AS expirationDate,
ROW_NUMBER() OVER (
PARTITION BY [workmatternumber]
ORDER BY MAX(COALESCE(NULL, [expirationDate], GETDATE())) DESC) AS rownum
FROM [stg].[Adjuster]
GROUP BY 	 
 [adjustedName],
 [workmatternumber]
),

WMAdjuster as (
select distinct [workmatternumber], [adjustedName] from  Adjuster WHERE
    rownum = 1
union

select distinct workmatternumber,'NA' as [adjustedName]   from[dm].[DimWorkmatter]
where workmatternumber in (select distinct workmatternumber
from stg.FactActuals
except
select distinct [workmatternumber]
from stg.Adjuster)

)


INSERT INTO
    [dm].[FactActuals](
[policy_SK], 
[policyEffectiveDate_SK]
,[policyExpirationDate_SK]
,[adjuster_SK]
,[claim_SK]
,[Exposure_SK]
,[exposureClosedDate_SK]
,[exposureOpenDate_SK]
,[exposureReopenDate_SK]
,[workMatter_SK]
,[workmatterOpenDate_SK]
,[workmatterClosedDate_SK]
,[workmatterReopenDate_SK]
,[valuationDate_SK]
,[caseAdjustingExpense]
,[caseCoverageDJExpense]
,[caseLoss]
,[paidAdjustingExpense]
,[paidCoverageDJExpense]
,[paidExpenseInLimits]
,[paidLoss]
,[recoveryDeductibleLoss]
,[recoverySalvage]
,[recoverySubrogationExpense]
,[recoverySubrogationLoss]
,[audit_Insert_Dt]
,[audit_Update_Dt]
,[ins_Proc_ID]
,[upd_Proc_ID]
,[is_Deleted]
,[is_Active]
    )


select 
ISNULL(P.policy_SK, 0) AS Policy_SK
,ISNULL(Dt1.Date_SK, 0) AS PolicyEffectiveDate_SK
,ISNULL(Dt2.Date_SK, 0) AS PolicyExpirationDate_SK
,ISNULL(DA.adjuster_SK,0) AS Adjuster_SK
,ISNULL(C.claim_SK, 0) AS claim_SK
,ISNULL(e.exposure_SK, 0) AS Exposure_SK
,ISNULL(Dt3.Date_SK, 0) AS ExposureClosedDate_SK
,ISNULL(Dt4.Date_SK, 0) AS ExposureOpenDate_SK
,ISNULL(Dt5.Date_SK, 0) AS ExposureReopenDate_SK
,ISNULL(w.workMatter_SK, 0) AS Workmatter_SK
,ISNULL(Dt6.Date_SK, 0) AS WorkmatterOpenDate_SK
,ISNULL(Dt7.Date_SK, 0) AS WorkmatterClosedDate_SK
,ISNULL(Dt8.Date_SK, 0) AS WorkmatterReopenDate_SK
,ISNULL(Dt9.Date_SK, 0) AS valuationDate_SK
,f.caseAdjustingExpense
,f.caseCoverageDJExpense
,f.caseLoss
,f.paidAdjustingExpense
,f.paidCoverageDJExpense
,f.paidexpenseinlimits
,f.paidLoss
,f.recoveryDeductibleLoss
,f.recoverySalvage
,f.recoverySubrogationExpense
,f.recoverySubrogationLoss
,@InsertDate AS [Audit_insert_dt]
,NULL AS [Audit_update_dt]
,@Ins_proc_id AS [Ins_proc_id]
,NULL AS [Upd_proc_id]
,0 AS [Is_deleted]
,1 AS [Is_active]


from stg.FactActuals F left join dm.DimClaim C on F.claimNumber=c.claimNo
left join dm.DimExposure e on f.claim_Exposure_No=e.claimExposureNo
left join stg.Exposure SE on SE.claim_Exposure_No=F.claim_Exposure_No
left join dm.DimWorkmatter w on F.workmatternumber=w.workmatternumber
left join stg.Workmatter SW on SW.workmatternumber=F.workmatternumber
left join dm.DimPolicy p on f.policy_No=p.policyNumber and f.portfolio_Cd=p.portfolioCode and f.[NAIC_Cd]=p.NAICCode
and f.[Business_Type_Cd]=p.businessTypeCode
left join WMAdjuster A on A.workmatternumber=F.workmatternumber
left  join dm.DimAdjuster DA on A.adjustedName=DA.adjusterName
LEFT JOIN [dm].[DimDate] Dt1 ON  F.policyEffectiveDate = Dt1.datefull
LEFT JOIN [dm].[DimDate] Dt2 ON  F.Policy_Expiration_Dt = Dt2.datefull
LEFT JOIN [dm].[DimDate] Dt3 ON  SE.exposureCloseDate = Dt3.datefull
LEFT JOIN [dm].[DimDate] Dt4 ON  SE.exposureOpenDate = Dt4.datefull
LEFT JOIN [dm].[DimDate] Dt5 ON  SE.exposureReOpenDate = Dt5.datefull
LEFT JOIN [dm].[DimDate] Dt6 ON  SW.workmatterOpenDate = Dt6.datefull
LEFT JOIN [dm].[DimDate] Dt7 ON  SW.workmattercloseddate = Dt7.datefull
LEFT JOIN [dm].[DimDate] Dt8 ON  SW.workmatterreopendate = Dt8.datefull
LEFT JOIN [dm].[DimDate] Dt9 ON  F.valuationdate = Dt9.datefull


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
