CREATE PROCEDURE [dm].[usp_DimDate]

AS

/*
Procedure Name:  [dm].[usp_DimDate]
Purpose: To load dates from the  staging to Datamart structure
Called by: loaded ones, can be called by any process
Calls: none
Database: Cashflow_DM (DEV, QA and PRD)
Date: 04/14/2020
Author: Aziz Z
Change Log: 
Date		By		Reason			
validation
************************************************************************************************************
exec [dm].[usp_DimDate]
************************************************************************************************************
*/
SET NOCOUNT ON;

BEGIN TRY

SET IDENTITY_INSERT dm.[DimDate] ON

INSERT INTO [dm].[DimDate]
		   ([Date_SK]           ,[DateKey]           ,[DateFull]           ,[DateFullName]           ,[Year]           ,[Quarter]
		   ,[QuarterKey]         ,[QuarterShortName]   ,[QuarterFullName]
		   ,[Month]           ,[MonthKey]           ,[MonthShortName]           ,[MonthFullName]
		   ,[MonthYearShortName]           ,[MonthYearFullName]           ,[DayOfMonth]
		   ,[DayOfYear]           ,[WeekOfYear]           ,[WeekOfYearKey]
		   ,[WeekDay]           ,[WeekDayName]           ,[IsWorkDay]           ,[WorkDayDescription]		   ,[YTDStartDate]           )
	 VALUES
		   (0           ,0           ,'01/01/1850'           ,'01/01/1850'           ,0           ,0
		   ,0           ,'NA'           ,'NA'           ,0           ,0           ,'NA'           ,'NA'
		   ,'NA'           ,'NA'           ,0           ,0           ,0           ,0           ,0
		   ,'NA'           ,0           ,'NA'		   ,'01/01/1850'           )

SET IDENTITY_INSERT dm.[DimDate] OFF

SET IDENTITY_INSERT dm.[DimDate] ON
 INSERT INTO  dm.[DimDate]( [Date_SK] ,[DateKey]  ,[DateFull] ,[DateFullName]  ,[Year] ,[Quarter]
		   ,[QuarterKey]         ,[QuarterShortName]   ,[QuarterFullName]
		   ,[Month]           ,[MonthKey]   ,[MonthShortName]           ,[MonthFullName]
		   ,[MonthYearShortName]           ,[MonthYearFullName] ,[DayOfMonth]
		   ,[DayOfYear]           ,[WeekOfYear]   ,[WeekOfYearKey]
		   ,[WeekDay]           ,[WeekDayName]   ,[IsWorkDay]     ,[WorkDayDescription] ,[YTDStartDate]  )

SELECT  [Date_SK]   ,[DateKey]   ,[DateFull]    ,[DateFullName]  ,[Year]    ,[Quarter]
		   ,[QuarterKey]       ,[QuarterShortName]   ,[QuarterFullName]
		   ,[Month]           ,[MonthKey]           ,[MonthShortName]           ,[MonthFullName]
		   ,[MonthYearShortName]   ,[MonthYearFullName]  ,[DayOfMonth]
		   ,[DayOfYear]   ,[WeekOfYear]   ,[WeekOfYearKey]
		   ,[WeekDay]   ,[WeekDayName]    ,[IsWorkDay]  ,[WorkDayDescription]	 ,[YTDStartDate] 
			FROM [stg].[Date] WHERE Date_SK <>0 

SET IDENTITY_INSERT dm.[DimDate] OFF

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
