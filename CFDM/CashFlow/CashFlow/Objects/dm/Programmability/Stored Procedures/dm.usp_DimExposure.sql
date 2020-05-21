CREATE PROCEDURE [dm].[usp_DimExposure]

AS
/*
Procedure Name:  [dm].[usp_DimExposure]
Purpose: To load exposure data from staging 
Called by: DF
Calls: none
Database: CashFlow_DM (DEV, QA and PRD)
Date: 05/21/2020
Author: Ragulan Vithurpan
Change Log:
Date		By		Reason			
validation
************************************************************************************************************
exec [dm].[usp_DimExposure]
************************************************************************************************************
*/
SET NOCOUNT ON;

BEGIN TRY

DECLARE @InsertDate DATETIME =GETDATE() -- Catching executiontime
DECLARE @Ins_proc_id INT= 5

--- Insert the NA value SK
SET IDENTITY_INSERT [dm].[DimExposure] ON 

INSERT INTO [dm].[DimExposure] ([exposure_SK],[claimExposureNo],[insuredName],[insuredLocation],[exposureStatus],
[audit_Insert_Dt],[audit_Update_Dt],[ins_Proc_ID],[upd_Proc_ID],[is_Deleted],[is_Active])

VALUES (0, 'NA','NA','NA','NA',@InsertDate,NULL, @Ins_proc_id,NULL,0,1)

SET IDENTITY_INSERT [dm].[DimExposure] OFF 

-- Load the data from stg to datamart

INSERT INTO [dm].[DimExposure] ([claimExposureNo],[insuredName],[insuredLocation],[exposureStatus],[audit_Insert_Dt]
,[audit_Update_Dt],[ins_Proc_ID],[upd_Proc_ID],[is_Deleted],[is_Active])

select distinct claim_Exposure_No, 
insuredName,
NULL as insuredLocation,
exposureStatus
,@InsertDate,
NULL, 
@Ins_proc_id,
NULL,
0 AS [Is_deleted],
1 AS [Is_active]
from [stg].[Exposure]


END TRY
    BEGIN CATCH

        DECLARE @ErrorMessage NVARCHAR(2000) = ERROR_MESSAGE();
        --Raise error
        RAISERROR(@ErrorMessage, 16, 1);
		INSERT INTO dm.Errors_log(  RunId ,  BatchId ,  UserName  ,  ErrorNumber   ,  ErrorState    ,
				  ErrorSeverity  ,  ErrorLine   ,  ErrorProcedure ,	  ErrorMessage  ,  ErrorDateTime )
		VALUES 	(0,0, SUSER_SNAME(), ERROR_NUMBER(),ERROR_STATE(), ERROR_SEVERITY(),
		 ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

    END CATCH;

