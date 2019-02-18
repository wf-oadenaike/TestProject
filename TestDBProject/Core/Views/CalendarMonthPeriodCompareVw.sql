
CREATE VIEW Core.CalendarMonthPeriodCompareVw
	AS 
	SELECT CalMMYYYY 
		, Minus1Month
		, Minus3Month
		, Minus6Month
		, Minus12Month
	FROM Core.CalendarMonthPeriodCompare
	;
