CREATE  NONCLUSTERED INDEX [ndx_AdjusterTRGUname] ON [dm].[DimAdjuster]
(
	[adjusterTRGUname] ASC
)WITH (IGNORE_DUP_KEY = ON)
