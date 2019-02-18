



-- =============================================
-- Author:		MF stolen from NI DI Custom Function
-- Create date: 2008/04/10
-- Description:	Check Cusip check-digit
-- =============================================
CREATE FUNCTION [dbo].[fnVALIDATE_CUSIP] 
(
	-- Add the parameters for the function here
	@CUSIP nvarchar(20)
)
RETURNS smallint
--WITH ENCRYPTION
AS
BEGIN
	-- Declare the return variable here
	DECLARE	@DIGITS char(16), @return smallint		
	-- initialisation
	set @return = 0
	if	(cast(@CUSIP as varbinary)!=cast(UPPER(@CUSIP) as varbinary)
	OR	@CUSIP IS NULL	 		-- can't be null
	OR	LEN(RTRIM(@CUSIP))!=9		-- must contain exactly 9 characters
	OR	@CUSIP LIKE '%[^A-Z,*,@,#,0-9]%'	-- can't contain anything other than alphanumerics, or * or @ or #
	OR	ISNUMERIC(RIGHT(@CUSIP,1))!=1)	--and rightmost character (checkdigit) must be numeric
		goto TheEnd
	set/*sp_password*/	@DIGITS=
		RIGHT ('0000000000000000' +
		CASE WHEN SUBSTRING(@CUSIP,1,1) = '*' THEN  '36'
		     WHEN SUBSTRING(@CUSIP,1,1) = '@' THEN  '37'
		     WHEN SUBSTRING(@CUSIP,1,1) = '#' THEN  '38'
		     WHEN (ISNUMERIC(SUBSTRING(@CUSIP,1,1))) = 1 THEN  RIGHT('0'+SUBSTRING(@CUSIP,1,1),2) 
		     ELSE CAST (ASCII(UPPER(SUBSTRING(@CUSIP,1,1)))  - 55 AS CHAR(2)) END + 
		CASE WHEN SUBSTRING(@CUSIP,2,1) = '*' THEN  '36'
		     WHEN SUBSTRING(@CUSIP,2,1) = '@' THEN  '37'
		     WHEN SUBSTRING(@CUSIP,2,1) = '#' THEN  '38'
		     WHEN (ISNUMERIC(SUBSTRING(@CUSIP,2,1))) = 1 THEN  RIGHT('0'+SUBSTRING(@CUSIP,2,1),2) 
		     ELSE CAST (ASCII(UPPER(SUBSTRING(@CUSIP,2,1)))  - 55 AS CHAR(2)) END  +
		CASE WHEN SUBSTRING(@CUSIP,3,1) = '*' THEN  '36'
		     WHEN SUBSTRING(@CUSIP,3,1) = '@' THEN  '37'
		     WHEN SUBSTRING(@CUSIP,3,1) = '#' THEN  '38'
		     WHEN (ISNUMERIC(SUBSTRING(@CUSIP,3,1))) = 1 THEN  RIGHT('0'+SUBSTRING(@CUSIP,3,1),2) 
		     ELSE CAST (ASCII(UPPER(SUBSTRING(@CUSIP,3,1)))  - 55 AS CHAR(2)) END  +
		CASE WHEN SUBSTRING(@CUSIP,4,1) = '*' THEN  '36'
		     WHEN SUBSTRING(@CUSIP,4,1) = '@' THEN  '37'
		     WHEN SUBSTRING(@CUSIP,4,1) = '#' THEN  '38'
		     WHEN (ISNUMERIC(SUBSTRING(@CUSIP,4,1))) = 1 THEN  RIGHT('0'+SUBSTRING(@CUSIP,4,1),2) 
		     ELSE CAST (ASCII(UPPER(SUBSTRING(@CUSIP,4,1)))  - 55 AS CHAR(2)) END  +
		CASE WHEN SUBSTRING(@CUSIP,5,1) = '*' THEN  '36'
		     WHEN SUBSTRING(@CUSIP,5,1) = '@' THEN  '37'
		     WHEN SUBSTRING(@CUSIP,5,1) = '#' THEN  '38'
		     WHEN (ISNUMERIC(SUBSTRING(@CUSIP,5,1))) = 1 THEN  RIGHT('0'+SUBSTRING(@CUSIP,5,1),2) 
		     ELSE CAST (ASCII(UPPER(SUBSTRING(@CUSIP,5,1)))  - 55 AS CHAR(2)) END  +
		CASE WHEN SUBSTRING(@CUSIP,6,1) = '*' THEN  '36'
		     WHEN SUBSTRING(@CUSIP,6,1) = '@' THEN  '37'
		     WHEN SUBSTRING(@CUSIP,6,1) = '#' THEN  '38'
		     WHEN (ISNUMERIC(SUBSTRING(@CUSIP,6,1))) = 1 THEN  RIGHT('0'+SUBSTRING(@CUSIP,6,1),2) 
		     ELSE CAST (ASCII(UPPER(SUBSTRING(@CUSIP,6,1)))  - 55 AS CHAR(2)) END  +
		CASE WHEN SUBSTRING(@CUSIP,7,1) = '*' THEN  '36'
		     WHEN SUBSTRING(@CUSIP,7,1) = '@' THEN  '37'
		     WHEN SUBSTRING(@CUSIP,7,1) = '#' THEN  '38'		
		     WHEN (ISNUMERIC(SUBSTRING(@CUSIP,7,1))) = 1 THEN  RIGHT('0'+SUBSTRING(@CUSIP,7,1),2) 
		     ELSE CAST (ASCII(UPPER(SUBSTRING(@CUSIP,7,1)))  - 55 AS CHAR(2)) END  +
		CASE WHEN SUBSTRING(@CUSIP,8,1) = '*' THEN  '36'
		     WHEN SUBSTRING(@CUSIP,8,1) = '@' THEN  '37'
		     WHEN SUBSTRING(@CUSIP,8,1) = '#' THEN  '38'		
		     WHEN (ISNUMERIC(SUBSTRING(@CUSIP,8,1))) = 1 THEN  RIGHT('0'+SUBSTRING(@CUSIP,8,1),2) 
		     ELSE CAST (ASCII(UPPER(SUBSTRING(@CUSIP,8,1)))  - 55 AS CHAR(2)) END ,16)
		/*****Check for errors*****/ select/*sp_password*/ @return=@@error if (@return<>0) goto TheEnd
	--Now calculate the expected checkdigit and compare to the actual
	if (ISNULL(ABS(RIGHT(10 - RIGHT(( 
		CASE WHEN SUBSTRING(@DIGITS,15,2) * 2  > 9 
			THEN	CAST(STR(RIGHT(SUBSTRING(@DIGITS,15,2) * 2,1)) AS INT) 
                                       	+ CAST(STR(LEFT(SUBSTRING(@DIGITS,15,2) * 2,1)) AS INT)
			ELSE 	    SUBSTRING(@DIGITS,15,2)   * 2
			END +
		CASE WHEN SUBSTRING(@DIGITS,13,2)  > 9 
			THEN	CAST(STR(RIGHT(SUBSTRING(@DIGITS,13,2),1)) AS INT) 
                                       	+ CAST(STR(LEFT(SUBSTRING(@DIGITS,13,2),1)) AS INT)
			ELSE 	    SUBSTRING(@DIGITS,13,2)
			END +
		CASE WHEN SUBSTRING(@DIGITS,11,2) * 2  > 9 
			THEN	CAST(STR( RIGHT(SUBSTRING(@DIGITS,11,2) * 2,1)) AS INT) 
                                       	+ CAST(STR(LEFT(SUBSTRING(@DIGITS,11,2) * 2,1)) AS INT)
			ELSE 	    SUBSTRING(@DIGITS,11,2)   * 2
			END +
		CASE WHEN SUBSTRING(@DIGITS,9,2)  > 9 
			THEN	CAST(STR(RIGHT(SUBSTRING(@DIGITS,9,2),1)) AS INT) 
                                       	+ CAST(STR(LEFT(SUBSTRING(@DIGITS,9,2),1)) AS INT)
			ELSE 	    SUBSTRING(@DIGITS,9,2)
			END +
		CASE WHEN SUBSTRING(@DIGITS,7,2) * 2  > 9 
			THEN	CAST(STR( RIGHT(SUBSTRING(@DIGITS,7,2) * 2,1)) AS INT) 
                                       	+ CAST(STR(LEFT(SUBSTRING(@DIGITS,7,2) * 2,1)) AS INT)
			ELSE 	    SUBSTRING(@DIGITS,7,2)   * 2
			END +
		CASE WHEN SUBSTRING(@DIGITS,5,2)  > 9 
			THEN	CAST(STR(RIGHT(SUBSTRING(@DIGITS,5,2),1)) AS INT) 
                                       	+ CAST(STR(LEFT(SUBSTRING(@DIGITS,5,2),1)) AS INT)
			ELSE 	    SUBSTRING(@DIGITS,5,2)
			END +
		CASE WHEN SUBSTRING(@DIGITS,3,2) * 2  > 9 
			THEN	CAST(STR( RIGHT(SUBSTRING(@DIGITS,3,2) * 2,1)) AS INT) 
                                       	+ CAST(STR(LEFT(SUBSTRING(@DIGITS,3,2) * 2,1)) AS INT)
			ELSE 	    SUBSTRING(@DIGITS,3,2)   * 2
			END +
		CASE WHEN SUBSTRING(@DIGITS,1,2)  > 9 
			THEN	CAST(STR(RIGHT(SUBSTRING(@DIGITS,1,2),1)) AS INT) 
                                       	+ CAST(STR(LEFT(SUBSTRING(@DIGITS,1,2),1)) AS INT)
			ELSE 	    SUBSTRING(@DIGITS,1,2)
			END 
		)
		,1),1)),0) = CAST(RIGHT(@CUSIP,1) AS INT))
		begin
			set @return = 1
			goto TheEnd
		end
		/*****Check for errors*****/ select/*sp_password*/ @return=@@error if (@return<>0) goto TheEnd
TheEnd:
	RETURN (@return)
END




