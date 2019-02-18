



-- =============================================a
-- Author:		MF stolen from NL DI Custom Function
-- Create date: 2008/02/18
-- Description:	Check Isin check-digit
-- =============================================
CREATE FUNCTION [dbo].[fnVALIDATE_ISIN] 
(
	-- Add the parameters for the function here
	@ISIN nchar(12)
)
RETURNS smallint
--WITH ENCRYPTION
AS
BEGIN
	-- Declare the return variable here
	DECLARE	@DIGITS nchar(22), @return	smallint		
	-- initialisation
	set/*sp_password*/	@return = 0
	--Lower case not allowed
	if cast(@ISIN as varbinary)!=cast(UPPER(@ISIN) as varbinary)
		GOTO TheEnd
	--Mark any obviously bad ones
	if	@ISIN IS NULL	 		-- can't be null
	OR	LEN(RTRIM(@ISIN))!=12		-- must contain exactly 12 characters
	OR	@ISIN LIKE '%[^A-Z,0-9]%'	-- can't contain anything other than alphanumerics
	OR	ISNUMERIC(RIGHT(@ISIN,1))!=1	--and rightmost character (checkdigit) must be numeric
	OR	NOT(UPPER(SUBSTRING(@ISIN,1,1)) BETWEEN 'A' AND 'Z') --First two chars must be country code
	OR	NOT(UPPER(SUBSTRING(@ISIN,2,1)) BETWEEN 'A' AND 'Z') --No "*" or any other crap
	OR	ISNUMERIC(RIGHT(@ISIN,1))!=1
	begin
		set @return = 0
		goto TheEnd
	end
		/*****Check for errors*****/ select/*sp_password*/ @return=@@error if (@return<>0) goto TheEnd
--now convert characters to ascii in order to do checksum calc
	set/*sp_password*/	
		@DIGITS =
		RIGHT ('0000000000000000000000' +
		cast(
		case 	when substring(@Isin,1,1) between 'A' and 'Z'then ascii(substring(@Isin,1,1))-55
			when substring(@Isin,1,1) between '0' and '9' then cast(substring(@Isin,1,1) as int)
		else	-1 end as varchar) +
		cast(
		case 	when substring(@Isin,2,1) between 'A' and 'Z'then ascii(substring(@Isin,2,1))-55
			when substring(@Isin,2,1) between '0' and '9' then cast(substring(@Isin,2,1) as int)
		else	-1 end as varchar) +
		cast(
		case 	when substring(@Isin,3,1) between 'A' and 'Z'then ascii(substring(@Isin,3,1))-55
			when substring(@Isin,3,1) between '0' and '9' then cast(substring(@Isin,3,1) as int)
		else	-1 end as varchar) +
		cast(
		case 	when substring(@Isin,4,1) between 'A' and 'Z'then ascii(substring(@Isin,4,1))-55
			when substring(@Isin,4,1) between '0' and '9' then cast(substring(@Isin,4,1) as int)
		else	-1 end as varchar) +
		cast(
		case 	when substring(@Isin,5,1) between 'A' and 'Z'then ascii(substring(@Isin,5,1))-55
			when substring(@Isin,5,1) between '0' and '9' then cast(substring(@Isin,5,1) as int)
		else	-1 end as varchar) +
		cast(
		case 	when substring(@Isin,6,1) between 'A' and 'Z'then ascii(substring(@Isin,6,1))-55
			when substring(@Isin,6,1) between '0' and '9' then cast(substring(@Isin,6,1) as int)
		else	-1 end as varchar) +
		cast(
		case 	when substring(@Isin,7,1) between 'A' and 'Z'then ascii(substring(@Isin,7,1))-55
			when substring(@Isin,7,1) between '0' and '9' then cast(substring(@Isin,7,1) as int)
		else	-1 end as varchar) +
		cast(
		case 	when substring(@Isin,8,1) between 'A' and 'Z'then ascii(substring(@Isin,8,1))-55
			when substring(@Isin,8,1) between '0' and '9' then cast(substring(@Isin,8,1) as int)
		else	-1 end as varchar) +
		cast(
		case 	when substring(@Isin,9,1) between 'A' and 'Z'then ascii(substring(@Isin,9,1))-55
			when substring(@Isin,9,1) between '0' and '9' then cast(substring(@Isin,9,1) as int)
		else	-1 end as varchar) +
		cast(
		case 	when substring(@Isin,10,1) between 'A' and 'Z'then ascii(substring(@Isin,10,1))-55
			when substring(@Isin,10,1) between '0' and '9' then cast(substring(@Isin,10,1) as int)
		else	-1 end as varchar) +
		cast(
		case 	when substring(@Isin,11,1) between 'A' and 'Z'then ascii(substring(@Isin,11,1))-55
			when substring(@Isin,11,1) between '0' and '9' then cast(substring(@Isin,11,1) as int)
		else	-1 end as varchar) 
		,22)
--calculate the expected checkdigit and subtract from the actual
	if (
		ISNULL(ABS(RIGHT(10 - 
		RIGHT( 
		(CASE WHEN SUBSTRING(@DIGITS,22,1) * 2  > 9 
			THEN	CAST(STR(RIGHT(SUBSTRING(@DIGITS,22,1) * 2,1)) AS INT) 
                                       	+ CAST(STR(LEFT(SUBSTRING(@DIGITS,22,1) * 2,1)) AS INT)
			ELSE 	    SUBSTRING(@DIGITS,22,1)   * 2
			END +
		CAST(SUBSTRING(@DIGITS,21,1) AS INT) +
		CASE WHEN SUBSTRING(@DIGITS,20,1) * 2  > 9 
			THEN	CAST(STR( RIGHT(SUBSTRING(@DIGITS,20,1) * 2,1)) AS INT) 
                                       	+ CAST(STR(LEFT(SUBSTRING(@DIGITS,20,1) * 2,1)) AS INT)
			ELSE 	    SUBSTRING(@DIGITS,20,1)   * 2
			END +
		CAST(SUBSTRING(@DIGITS,19,1) AS INT) +
		CASE WHEN SUBSTRING(@DIGITS,18,1) * 2  > 9 
			THEN	CAST(STR( RIGHT(SUBSTRING(@DIGITS,18,1) * 2,1)) AS INT) 
                                       	+ CAST(STR(LEFT(SUBSTRING(@DIGITS,18,1) * 2,1)) AS INT)
			ELSE 	    SUBSTRING(@DIGITS,18,1)   * 2
			END +
		CAST(SUBSTRING(@DIGITS,17,1) AS INT) +
		CASE WHEN SUBSTRING(@DIGITS,16,1) * 2  > 9 
			THEN	CAST(STR( RIGHT(SUBSTRING(@DIGITS,16,1) * 2,1)) AS INT) 
                                       	+ CAST(STR(LEFT(SUBSTRING(@DIGITS,16,1) * 2,1)) AS INT)
			ELSE 	    SUBSTRING(@DIGITS,16,1)   * 2
			END +
		CAST(SUBSTRING(@DIGITS,15,1) AS INT) +
		CASE WHEN SUBSTRING(@DIGITS,14,1) * 2  > 9 
			THEN	CAST(STR( RIGHT(SUBSTRING(@DIGITS,14,1) * 2,1)) AS INT) 
                                       	+ CAST(STR(LEFT(SUBSTRING(@DIGITS,14,1) * 2,1)) AS INT)
			ELSE 	    SUBSTRING(@DIGITS,14,1)   * 2
			END +
		CAST(SUBSTRING(@DIGITS,13,1) AS INT) +
		CASE WHEN SUBSTRING(@DIGITS,12,1) * 2  > 9 
			THEN	CAST(STR( RIGHT(SUBSTRING(@DIGITS,12,1) * 2,1)) AS INT) 
                                       	+ CAST(STR(LEFT(SUBSTRING(@DIGITS,12,1) * 2,1)) AS INT)
			ELSE 	    SUBSTRING(@DIGITS,12,1)   * 2
			END +
		CAST(SUBSTRING(@DIGITS,11,1) AS INT) +
		CASE WHEN SUBSTRING(@DIGITS,10,1) * 2  > 9 
			THEN	CAST(STR( RIGHT(SUBSTRING(@DIGITS,10,1) * 2,1)) AS INT) 
                                       	+ CAST(STR(LEFT(SUBSTRING(@DIGITS,10,1) * 2,1)) AS INT)
			ELSE 	    SUBSTRING(@DIGITS,10,1)   * 2
			END +
		CAST(SUBSTRING(@DIGITS,9,1) AS INT) +
		CASE WHEN SUBSTRING(@DIGITS,8,1) * 2  > 9 
			THEN	CAST(STR( RIGHT(SUBSTRING(@DIGITS,8,1) * 2,1)) AS INT) 
                                       	+ CAST(STR(LEFT(SUBSTRING(@DIGITS,8,1) * 2,1)) AS INT)
			ELSE 	    SUBSTRING(@DIGITS,8,1)   * 2
			END +
		CAST(SUBSTRING(@DIGITS,7,1) AS INT) +
		CASE WHEN SUBSTRING(@DIGITS,6,1) * 2  > 9 
			THEN	CAST(STR( RIGHT(SUBSTRING(@DIGITS,6,1) * 2,1)) AS INT) 
                                       	+ CAST(STR(LEFT(SUBSTRING(@DIGITS,6,1) * 2,1)) AS INT)
			ELSE 	    SUBSTRING(@DIGITS,6,1)   * 2
			END +
		CAST(SUBSTRING(@DIGITS,5,1) AS INT) +
		CASE WHEN SUBSTRING(@DIGITS,4,1) * 2  > 9 
			THEN	CAST(STR( RIGHT(SUBSTRING(@DIGITS,4,1) * 2,1)) AS INT) 
                                       	+ CAST(STR(LEFT(SUBSTRING(@DIGITS,4,1) * 2,1)) AS INT)
			ELSE 	    SUBSTRING(@DIGITS,4,1)   * 2
			END +
		CAST(SUBSTRING(@DIGITS,3,1) AS INT) +
		CASE WHEN SUBSTRING(@DIGITS,2,1) * 2  > 9 
			THEN	CAST(STR( RIGHT(SUBSTRING(@DIGITS,2,1) * 2,1)) AS INT) 
                                       	+ CAST(STR(LEFT(SUBSTRING(@DIGITS,2,1) * 2,1)) AS INT)
			ELSE 	    SUBSTRING(@DIGITS,2,1)   * 2
			END +
		CAST(SUBSTRING(@DIGITS,1,1) AS INT)
		),1)
		,1)),0)  /* RIGHTMOST CHAR */
	= CAST(RIGHT(@ISIN,1) AS INT)) /* SUBTRACT CHECKDIGIT */
		begin
			Set @return = 1		
			goto TheEnd
		end
		/*****Check for errors*****/ select/*sp_password*/ @return=@@error if (@return<>0) goto TheEnd
TheEnd:
	RETURN (@return)
END




