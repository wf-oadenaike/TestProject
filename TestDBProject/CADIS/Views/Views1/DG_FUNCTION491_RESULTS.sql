﻿CREATE VIEW "CADIS"."DG_FUNCTION491_RESULTS" AS 
SELECT ET."ROW_UNIQUE_ID",ET."DVD_Overrides_ID",ET."DVD_Fund_Overrides_ID",ET."EDM_SEC_ID",ET."SecurityName",ET."FundShortName",ET."ExDate",ET."DvdValue_ExDate",ET."OriginalDvdValue_ExDate",ET."Quantity_ExDate",ET."Quantity_LastDate",ET."Position_LastDate",ET."Quantity_FirstDate",ET."Position_FirstDate",ET."Quantity_DvdCalc",ET."GrossDvdValue",ET."NetDvdValue",ET."SpecialCumTrades",ET."WithholdingTax",ET."DvdCCY",ET."Qtr",ET."Yr",ET."SpotRate",ET."Ticker",ET."HasOverride" FROM "Access.ManyWho"."Recalc_Overrides" ET WITH (NOLOCK)