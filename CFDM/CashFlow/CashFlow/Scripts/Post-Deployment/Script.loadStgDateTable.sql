  IF(NOT EXISTS(SELECT TOP 1 1 FROM [stg].[Date]))
    BEGIN
		 
		Exec [stg].[usp_loadDate]
    END

   IF(NOT EXISTS(SELECT TOP 1 1 FROM [dm].[DimDate]))
    BEGIN
		Exec [dm].[usp_DimDate]
   END
