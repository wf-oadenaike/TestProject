
CREATE VIEW Core.CalendarPeriodCompareVw
AS
SELECT 	CalendarId
	, FirstOfMinus1Month
	, FisrtOfMinus3Months
	, FisrtOfMinus6Months
	, FisrtOfMinus12Months
	, Minus1Month
	, Minus3Months
	, Minus6Months
	, Minus12Months
	FROM  Core.CalendarPeriodCompare
	;
