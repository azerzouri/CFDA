CREATE PROCEDURE [stg].[usp_loadDate]

AS

/*
Procedure Name:  stg.usp_loadDate
Purpose: To load Claimant data from the raw schema to staging structure
Called by: loaded ones, can be called by any process
Calls: none
Database: Asbestos_DM (DEV, QA and PRD)
Date: 09/24/2019
Author: Aziz
Change Log:
Date		By		Reason			
test
************************************************************************************************************
exec stg.usp_loadDate
************************************************************************************************************
*/
Begin

Declare @STARTDT DATETIME, @ENDDT DATETIME, @Ncount Int
Set @STARTDT = '1900-01-01'
Set @ENDDT = '2050-12-31'


Select @Ncount = COUNT(1) FROM stg.[Date]

If (@Ncount = 0)
Begin
Declare @@TempDate TABLE(
	   [DateKey] [int] Null,
	   [DateFull] [date] Null,
	   [DateFullName] [char](11) Null,
	   [Year] [int] Null,
	   [Quarter] [int] Null,
	   [QuarterKey] [int] Null,
	   [QuarterShortName] [char](2) Null,
	   [QuarterFullName] [char](6) Null,
	   [Month] [int] Null,
	   [MonthKey] [int] NULL,
	   [MonthShortName] [char](3) NULL,
	   [MonthFullName] [char](9) NULL,
	   [MonthYearShortName] [char](8) NULL,
	   [MonthYearFullName] [char](14) NULL,
	   [DayOfMonth] [int] NULL,
	   [DayOfYear] [int] NULL,
	   [WeekOfYear] [int] NULL,
	   [WeekOfYearKey] [int] NULL,
	   [WeekDay] [int] NULL,
	   [WeekDayName] [char](9) NULL,
	   [IsWorkDay] [bit] NULL,
	   [WorkDayDescription] [char](7) NULL,
	   [YTDStartDate] [date] NULL
)


While (@STARTDT <= @ENDDT)
BEGIN

	   Insert Into @@TempDate     --[dbo].[DimDate]
	   (         [DateKey]
				,[DateFull]
				,[DateFullName]
				,[Year]
				,[Quarter]
				,[QuarterKey]
				,[QuarterShortName]
				,[QuarterFullName]
				,[Month]
				,[MonthKey]
				,[MonthShortName]
				,[MonthFullName]
				,[MonthYearShortName]
				,[MonthYearFullName]
				,[DayOfMonth]
				,[DayOfYear]
				,[WeekOfYear]
				,[WeekOfYearKey]
				,[WeekDay]
				,[WeekDayName]
				,[IsWorkDay]
				,[WorkDayDescription]
				,[YTDStartDate]
			  )
	   Select CAST(Convert(Varchar(10),@STARTDT,112) As INT) As Date_SK
	   , CAST(Convert(Varchar(10),@STARTDT,121) As DATE) As DateFull
	   , Right('00' + CAST(Day(@STARTDT) As Varchar(2)),2) + ' ' + SubString(Datename(month,@STARTDT),1,3) + ' ' +CAST(Year(@STARTDT) As Varchar) As DateFullName
	   , Year(@STARTDT) As [Year]
	   , Datepart(qq,@STARTDT) As [Quarter]
	   , CAST(Year(@STARTDT) As Varchar) + Right('00' + CAST(Datepart(qq,@STARTDT) As Varchar),2) AS QuarterKey
	   , 'Q' + CAST(Datepart(qq,@STARTDT)As Varchar) As QuarterShortName
	   , CAST(Year(@STARTDT) As Varchar) + 'Q' + CAST(Datepart(qq,@STARTDT) As Varchar) As QuarterFullName
	   , Month(@STARTDT) As [Month]
	   , CAST(Year(@STARTDT) As Varchar) + Right('00' + CAST(Month(@STARTDT) As Varchar), 2) As MonthKey
	   , SubString(DateName(Month,@STARTDT),1,3) As MonthShortName
	   , DateName(Month,@STARTDT) As MonthFullName
	   , SubString(DateName(Month,@STARTDT),1,3) + ' ' + CAST(Year(@STARTDT) As Varchar) As MonthYearShortName
	   , DateName(Month,@STARTDT) + ' ' + CAST(Year(@STARTDT) As Varchar) As MonthYearFullName
	   , Day(@STARTDT) As [DayOfMonth]
	   , Datepart(dy,@STARTDT) As [DayOfYear]
	   , Datepart(wk,@STARTDT) As [WeekOfYear]
	   , CAST(Year(@STARTDT) As Varchar) + Right('00' + CAST(Datepart(wk,@STARTDT) As Varchar), 2) As WeekOfYearKey

	   , CAST(Datepart(dw,@STARTDT) As Varchar) As [WeekDay]
	   , DateName(Weekday,@STARTDT) As [WeekDayName]
	   , CASE When (DatePart(dw,@STARTDT) In (1,7)) Then 0 Else 1 End As IsWorkDay
	   , CASE When (DatePart(dw,@STARTDT) In (1,7)) Then 'Weekend' Else 'Workday' End As WorkDayDescription
	   , CAST(CONVERT(varchar(10),DATEADD(YEAR,DATEDIFF(YEAR,0,@StartDt),0),121) AS DATE) AS YTDStartDate

	   Set @STARTDT = DateAdd(dd,1,@STARTDT)

END
--------------------------------------------
Insert Into  stg.[Date]
	   (         [DateKey]
				,[DateFull]
				,[DateFullName]
				,[Year]
				,[Quarter]
				,[QuarterKey]
				,[QuarterShortName]
				,[QuarterFullName]
				,[Month]
				,[MonthKey]
				,[MonthShortName]
				,[MonthFullName]
				,[MonthYearShortName]
				,[MonthYearFullName]
				,[DayOfMonth]
				,[DayOfYear]
				,[WeekOfYear]
				,[WeekOfYearKey]
				,[WeekDay]
				,[WeekDayName]
				,[IsWorkDay]
				,[WorkDayDescription]
				,[YTDStartDate]
			  )
Select [DateKey]
	  ,[DateFull]
	  ,[DateFullName]
	  ,[Year]
	  ,[Quarter]
	  ,[QuarterKey]
	  ,[QuarterShortName]
	  ,[QuarterFullName]
	  ,[Month]
	  ,[MonthKey]
	  ,[MonthShortName]
	  ,[MonthFullName]
	  ,[MonthYearShortName]
	  ,[MonthYearFullName]
	  ,[DayOfMonth]
	  ,[DayOfYear]
	  ,[WeekOfYear]
	  ,[WeekOfYearKey]
	  ,[WeekDay]
	  ,[WeekDayName]
	  ,[IsWorkDay]
	  ,[WorkDayDescription]
	  ,[YTDStartDate]
From @@TempDate
Order By DateKey
End

IF NOT EXISTS (SELECT 1 FROM [stg].[Date] d where d.Date_SK=0)
BEGIN
Set IDENTITY_INSERT [stg].[Date] ON 
INSERT INTO [stg].[Date]
		   ([Date_SK]
		   ,[DateKey]
		   ,[DateFull]
		   ,[DateFullName]
		   ,[Year]
		   ,[Quarter]
		   ,[QuarterKey]
		   ,[QuarterShortName]
		   ,[QuarterFullName]
		   ,[Month]
		   ,[MonthKey]
		   ,[MonthShortName]
		   ,[MonthFullName]
		   ,[MonthYearShortName]
		   ,[MonthYearFullName]
		   ,[DayOfMonth]
		   ,[DayOfYear]
		   ,[WeekOfYear]
		   ,[WeekOfYearKey]
		   ,[WeekDay]
		   ,[WeekDayName]
		   ,[IsWorkDay]
		   ,[WorkDayDescription]
		   ,[YTDStartDate]
		   )
	 VALUES
		   (0
		   ,0
		   ,NULL
		   ,NULL
		   ,0
		   ,0
		   ,0
		   ,'NA'
		   ,'NA'
		   ,0
		   ,0
		   ,'NA'
		   ,'NA'
		   ,'NA'
		   ,'NA'
		   ,0
		   ,0
		   ,0
		   ,0
		   ,0
		   ,'NA'
		   ,0
		   ,'NA'
		   ,NULL
		   )
Set IDENTITY_INSERT [stg].[Date] OFF 
END
End