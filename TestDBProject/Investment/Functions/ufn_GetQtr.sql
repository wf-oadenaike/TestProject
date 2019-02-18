CREATE FUNCTION Investment.ufn_GetQtr(@Date date)  
RETURNS char(5)
AS   
-- Return the Qtr for the calendar year 
BEGIN  
    DECLARE @ret char(5);  
	DECLARE @Year char(4);

	--get year for @Date
	SET @Year = CAST(YEAR(@Date) as varchar);
	
	SET @ret = (CASE WHEN @Date BETWEEN CONVERT(DATETIME,@Year +'0101') AND CONVERT(DATETIME,@Year +'0331') THEN 'Q1 ' + SUBSTRING(@Year,3,2)
		 WHEN @Date BETWEEN CONVERT(DATETIME,@Year +'0401') AND CONVERT(DATETIME,@Year +'0630') THEN 'Q2 ' + SUBSTRING(@Year,3,2)
		 WHEN @Date BETWEEN CONVERT(DATETIME,@Year +'0701') AND CONVERT(DATETIME,@Year +'0930') THEN 'Q3 ' + SUBSTRING(@Year,3,2)
		 ELSE 'Q4 ' + SUBSTRING(@Year,3,2)
		 END);
	
    RETURN @ret;  
END;
