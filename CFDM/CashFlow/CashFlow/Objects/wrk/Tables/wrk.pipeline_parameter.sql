CREATE TABLE [wrk].[pipeline_parameter](
   [ID]  INT IDENTITY(1,1) PRIMARY KEY,
   [Table_Name] [varchar](500) NULL,
   [TABLE_CATALOG] [varchar](500) NULL,
   [process_type] [varchar](500) NULL,
   [SQLtxt]  [varchar](MAX) NULL,
   [InsertedDate] [DATETIME] DEFAULT getdate() NOT NULL,
)
