CREATE TABLE [dm].[Errors_log](
	[ErrorID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	[RunId] [int] NULL,
	[BatchId] [int] NULL,
	[UserName] [varchar](100) NULL,
	[ErrorNumber] [int] NULL,
	[ErrorState] [int] NULL,
	[ErrorSeverity] [int] NULL,
	[ErrorLine] [int] NULL,
	[ErrorProcedure] [varchar](max) NULL,
	[ErrorMessage] [varchar](max) NULL,
	[ErrorDateTime] [datetime] NULL,
)
