﻿CREATE UNIQUE INDEX ndx_stg_CashFlow_HashKey ON stg.FactCashflow(FactCashFlowHashKey)
WITH IGNORE_DUP_KEY