CREATE NONCLUSTERED INDEX [ndx_DerivedClaimNumber_DimExposure] ON [dm].[DimExposure]
(
	[claimNumber] ASC
)