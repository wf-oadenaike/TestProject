﻿CREATE VIEW "CADIS"."DG_FUNCTION747_RESULTS" AS 
SELECT ET."EDM_SEC_ID",ET."FundShortName",ET."CalendarYear",ET."SecurityName",ET."DvdCCY",ET."WithholdingTax",ET."SpotRate",ET."DeclaredDate",ET."PositionDate",ET."BidPrice",ET."Position",ET."MarketValue",ET."Q1ExDate",ET."Q1Rate",ET."Q1Income",ET."Q1ToPay",ET."Q2ExDate",ET."Q2Rate",ET."Q2Income",ET."Q2ToPay",ET."Q3ExDate",ET."Q3Rate",ET."Q3Income",ET."Q3ToPay",ET."Q4ExDate",ET."Q4Rate",ET."Q4Income",ET."Q4ToPay",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."SourceQ1ExDate",ET."SourceQ1Rate",ET."SourceQ2ExDate",ET."SourceQ2Rate",ET."SourceQ3ExDate",ET."SourceQ3Rate",ET."SourceQ4ExDate",ET."SourceQ4Rate" FROM "CADIS"."VW_Master_Dividend_Forecast" ET WITH (NOLOCK)