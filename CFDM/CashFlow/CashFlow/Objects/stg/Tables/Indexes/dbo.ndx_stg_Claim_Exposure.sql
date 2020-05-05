CREATE NONCLUSTERED INDEX [ndx_stg_Claim_Exposure] ON [stg].[Reinsurance]
(
	[claimNumber] ASC,
	[exposure_No] ASC
)