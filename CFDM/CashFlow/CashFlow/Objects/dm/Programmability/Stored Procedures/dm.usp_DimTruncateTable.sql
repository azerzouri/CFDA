CREATE PROCEDURE [dm].[usp_DimTruncateTable] (@schemaName varchar(64) = 'dm') AS
/*
 Procedure Name:  [dm].[usp_DimTruncateTable]
 Purpose: To truncate table before load
 Called by: DF
 Calls: none
 Database: CashFlow_DM (DEV, QA and PRD)
 Date: 10/10/2019
 Author: Aziz Z.
 Change Log:
 Date		By		Reason			
 validation
 ************************************************************************************************************
 for dm schema:
 exec [dm].[usp_DimTruncateTable] @schemaName ='dm'
 
 For Stg schema:
 exec [dm].[usp_DimTruncateTable] @schemaName ='stg'
 ************************************************************************************************************
 */
BEGIN TRY if(@schemaName = 'dm') BEGIN exec [wrk].[ups_Drop_Create_ForeignKeys] @execStep = 'DROP'
END DECLARE @sql varchar(max) DECLARE @Database varchar(64)
SELECT
	@Database = DB_NAME();

DECLARE @Schema varchar(64) = @schemaName
SET
	@sql = '' IF (@Schema = 'stg') BEGIN
SET
	@sql =(
		SELECT
			' Truncate Table ' + @Database + '.' + @Schema + '.' + table_name + char(13) + char(10)
		FROM
			INFORMATION_SCHEMA.TABLES
		WHERE
			TABLE_SCHEMA = @schema
			AND TABLE_NAME NOT IN ('FactCashflow', 'Date', 'Reinsurance','FactCashflow_org') FOR XML PATH(''),
			TYPE
	).value('.', 'NVARCHAR(MAX)')
END
ELSE BEGIN
SET
	@sql =(
		SELECT
			' Truncate Table ' + @Database + '.' + @Schema + '.' + table_name + char(13) + char(10)
		FROM
			INFORMATION_SCHEMA.TABLES
		WHERE
			TABLE_SCHEMA = @schema
			AND TABLE_NAME <> 'DimDate' FOR XML PATH(''),
			TYPE
	).value('.', 'NVARCHAR(MAX)')
END --select @sql
EXEC(@sql)
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