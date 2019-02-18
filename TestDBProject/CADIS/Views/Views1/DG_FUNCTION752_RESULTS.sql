CREATE VIEW "CADIS"."DG_FUNCTION752_RESULTS" AS 
SELECT ET."FundShortName",ET."EDM_SEC_ID",ET."CalendarYear",ET."SecurityName",ET."DeclaredDate",ET."DvdCCY",ET."SpotRate",ET."Position",ET."PositionDate",ET."BidPrice",ET."WithholdingTax",ET."Q1ExDate",ET."Q1Rate",ET."Q2ExDate",ET."Q2Rate",ET."Q3ExDate",ET."Q3Rate",ET."Q4ExDate",ET."Q4Rate" FROM "dbo"."ufn_DividendForecast"() ET
