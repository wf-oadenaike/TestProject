﻿CREATE VIEW "CADIS"."IL_Fund_Quarterly_Income" AS 
SELECT V."VALUATION_DATE" AS "Valuation Date",V."FUND_SHORT_NAME" AS "Fund Short Name",V."FUND_FISCAL_YEAR" AS "Fund FIscal Year",V."FUND_FISCAL_QUARTER" AS "Fund Fiscal Quarter",V."EARNED_INCOME" AS "Income Earned",V."TO_PAY" AS "Yet To Go XD",V."UNITS_IN_ISSUE" AS "Units In Issue",V."NET_INCOME" AS "Net Income",V."P.P.U" AS "P.P.U" FROM "CADIS"."VW_UI_FND_QUARTERLY_INCOME" V
