CREATE UNIQUE INDEX ndx_Comp_Unique_DimPolicy ON dm.DimPolicy(policyNumber, portfolioCode, NAICCode, businessTypeCode)
WITH IGNORE_DUP_KEY
