CREATE NONCLUSTERED INDEX [ndx_DerivedClaimNumber_FactCashflow] ON [stg].[FactCashflow]
(
	[claimNumber] ASC
)