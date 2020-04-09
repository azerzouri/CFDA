/* 
 * TABLE: dm.DimDate 
 */

ALTER TABLE dm.DimDate ADD CONSTRAINT RefFactCashFlow77 
    FOREIGN KEY (factCashflowID)
    REFERENCES dm.FactCashFlow(factCashflowID)
go


/* 
 * TABLE: dm.FactActuals 
 */

ALTER TABLE dm.FactActuals ADD CONSTRAINT RefDimPolicyCoverage61 
    FOREIGN KEY (policyCoverage_SK)
    REFERENCES dm.DimPolicyCoverage(policyCoverage_SK)
go

ALTER TABLE dm.FactActuals ADD CONSTRAINT RefDimDate62 
    FOREIGN KEY (valuationDate_SK)
    REFERENCES dm.DimDate(Date_SK)
go

ALTER TABLE dm.FactActuals ADD CONSTRAINT RefDimWorkmatter63 
    FOREIGN KEY (workMatter_SK)
    REFERENCES dm.DimWorkmatter(workMatter_SK)
go

ALTER TABLE dm.FactActuals ADD CONSTRAINT RefDimReinsurance64 
    FOREIGN KEY (reinsurane_SK)
    REFERENCES dm.DimReinsurance(reinsurane_SK)
go

ALTER TABLE dm.FactActuals ADD CONSTRAINT RefDimAdjuster65 
    FOREIGN KEY (adjuster_SK)
    REFERENCES dm.DimAdjuster(adjuster_SK)
go

ALTER TABLE dm.FactActuals ADD CONSTRAINT RefDimExposure66 
    FOREIGN KEY (Exposure_SK)
    REFERENCES dm.DimExposure(Exposure_SK)
go

ALTER TABLE dm.FactActuals ADD CONSTRAINT RefDimDate67 
    FOREIGN KEY (exposureOpenDate_SK)
    REFERENCES dm.DimDate(Date_SK)
go

ALTER TABLE dm.FactActuals ADD CONSTRAINT RefDimDate68 
    FOREIGN KEY (exposureClosedDate_SK)
    REFERENCES dm.DimDate(Date_SK)
go

ALTER TABLE dm.FactActuals ADD CONSTRAINT RefDimDate69 
    FOREIGN KEY (exposureReopenDate_SK)
    REFERENCES dm.DimDate(Date_SK)
go

ALTER TABLE dm.FactActuals ADD CONSTRAINT RefDimDate70 
    FOREIGN KEY (policyEffectiveDate_SK)
    REFERENCES dm.DimDate(Date_SK)
go

ALTER TABLE dm.FactActuals ADD CONSTRAINT RefDimDate71 
    FOREIGN KEY (policyExpirationDate_SK)
    REFERENCES dm.DimDate(Date_SK)
go

ALTER TABLE dm.FactActuals ADD CONSTRAINT RefDimClaim72 
    FOREIGN KEY (claim_SK)
    REFERENCES dm.DimClaim(claim_SK)
go

ALTER TABLE dm.FactActuals ADD CONSTRAINT RefDimDate73 
    FOREIGN KEY (workmatterOpenDate_SK)
    REFERENCES dm.DimDate(Date_SK)
go

ALTER TABLE dm.FactActuals ADD CONSTRAINT RefDimDate74 
    FOREIGN KEY (workmatterClosedDate_SK)
    REFERENCES dm.DimDate(Date_SK)
go

ALTER TABLE dm.FactActuals ADD CONSTRAINT RefDimDate75 
    FOREIGN KEY (workmatterReopenDate_SK)
    REFERENCES dm.DimDate(Date_SK)
go

ALTER TABLE dm.FactActuals ADD CONSTRAINT RefDimPolicy60 
    FOREIGN KEY (policy_SK)
    REFERENCES dm.DimPolicy(policy_SK)
go


/* 
 * TABLE: dm.FactCashFlow 
 */

ALTER TABLE dm.FactCashFlow ADD CONSTRAINT RefDimClaim76 
    FOREIGN KEY (claim_SK)
    REFERENCES dm.DimClaim(claim_SK)
go

ALTER TABLE dm.FactCashFlow ADD CONSTRAINT RefDimDate1 
    FOREIGN KEY (valuationDate_SK)
    REFERENCES dm.DimDate(Date_SK)
go

ALTER TABLE dm.FactCashFlow ADD CONSTRAINT RefDimWorkmatter2 
    FOREIGN KEY (workMatter_SK)
    REFERENCES dm.DimWorkmatter(workMatter_SK)
go

ALTER TABLE dm.FactCashFlow ADD CONSTRAINT RefDimPolicyCoverage4 
    FOREIGN KEY (policyCoverage_SK)
    REFERENCES dm.DimPolicyCoverage(policyCoverage_SK)
go

ALTER TABLE dm.FactCashFlow ADD CONSTRAINT RefDimPolicy5 
    FOREIGN KEY (policy_SK)
    REFERENCES dm.DimPolicy(policy_SK)
go

ALTER TABLE dm.FactCashFlow ADD CONSTRAINT RefDimReinsurance9 
    FOREIGN KEY (reinsurane_SK)
    REFERENCES dm.DimReinsurance(reinsurane_SK)
go

ALTER TABLE dm.FactCashFlow ADD CONSTRAINT RefDimNotifications10 
    FOREIGN KEY (notification_SK)
    REFERENCES dm.DimNotifications(notification_SK)
go

ALTER TABLE dm.FactCashFlow ADD CONSTRAINT RefDimAdjuster30 
    FOREIGN KEY (adjuster_SK)
    REFERENCES dm.DimAdjuster(adjuster_SK)
go

ALTER TABLE dm.FactCashFlow ADD CONSTRAINT RefDimExposure32 
    FOREIGN KEY (Exposure_SK)
    REFERENCES dm.DimExposure(Exposure_SK)
go

ALTER TABLE dm.FactCashFlow ADD CONSTRAINT RefDimDate34 
    FOREIGN KEY (exposureOpenDate_SK)
    REFERENCES dm.DimDate(Date_SK)
go

ALTER TABLE dm.FactCashFlow ADD CONSTRAINT RefDimDate35 
    FOREIGN KEY (exposureClosedDate_SK)
    REFERENCES dm.DimDate(Date_SK)
go

ALTER TABLE dm.FactCashFlow ADD CONSTRAINT RefDimDate36 
    FOREIGN KEY (exposerReopenDate_SK)
    REFERENCES dm.DimDate(Date_SK)
go

ALTER TABLE dm.FactCashFlow ADD CONSTRAINT RefDimDate40 
    FOREIGN KEY (policyEffectiveDate_SK)
    REFERENCES dm.DimDate(Date_SK)
go

ALTER TABLE dm.FactCashFlow ADD CONSTRAINT RefDimDate41 
    FOREIGN KEY (policyExpirationDate_SK)
    REFERENCES dm.DimDate(Date_SK)
go

ALTER TABLE dm.FactCashFlow ADD CONSTRAINT RefDimDate44 
    FOREIGN KEY (entryDate_SK)
    REFERENCES dm.DimDate(Date_SK)
go

ALTER TABLE dm.FactCashFlow ADD CONSTRAINT RefDimDate45 
    FOREIGN KEY (projectionDate_SK)
    REFERENCES dm.DimDate(Date_SK)
go

ALTER TABLE dm.FactCashFlow ADD CONSTRAINT RefDimDate52 
    FOREIGN KEY (workmatterOpenDate_SK)
    REFERENCES dm.DimDate(Date_SK)
go

ALTER TABLE dm.FactCashFlow ADD CONSTRAINT RefDimDate57 
    FOREIGN KEY (workmatter_ClosedDate_SK)
    REFERENCES dm.DimDate(Date_SK)
go

ALTER TABLE dm.FactCashFlow ADD CONSTRAINT RefDimDate59 
    FOREIGN KEY (workmatterReopenDate_SK)
    REFERENCES dm.DimDate(Date_SK)
go


