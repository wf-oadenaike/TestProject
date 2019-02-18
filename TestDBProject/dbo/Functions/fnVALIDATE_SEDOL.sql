



-- =============================================a
-- Author:		MF stolen from NL DI Custom Function
-- Create date: 2008/04/10
-- Description:	Check Sedol check-digit
-- =============================================
CREATE FUNCTION [dbo].[fnVALIDATE_SEDOL] 
(
	-- Add the parameters for the function here
	@SEDOL nvarchar(20)
)
RETURNS smallint
--WITH ENCRYPTION
AS
BEGIN
	-- Declare the return variable here
	DECLARE	@return	smallint		
	-- initialisation
	set/*sp_password*/	@return = 0
	if	(	cast(@SEDOL as varbinary)!=cast(UPPER(@SEDOL) as varbinary)
		OR	NOT (@SEDOL IS NOT NULL AND LEN(RTRIM(@SEDOL)) = 7 
			AND		(
					(ISNUMERIC(SUBSTRING(@SEDOL,1,1))=1
					AND ISNUMERIC(SUBSTRING(@SEDOL,2,1))=1
					AND ISNUMERIC(SUBSTRING(@SEDOL,3,1))=1
					AND ISNUMERIC(SUBSTRING(@SEDOL,4,1))=1
					AND ISNUMERIC(SUBSTRING(@SEDOL,5,1))=1
					AND ISNUMERIC(SUBSTRING(@SEDOL,6,1))=1
					AND ISNUMERIC(SUBSTRING(@SEDOL,7,1))=1
					) --old style numeric sedol
					OR
					(( SUBSTRING(@SEDOL,1,1) between 'B' and 'Z' AND SUBSTRING(@SEDOL,1,1) not in ('E','I','O','U') ) 
		    		AND ( ( SUBSTRING(@SEDOL,2,1) between 'B' and 'Z' AND SUBSTRING(@SEDOL,2,1) not in ('E','I','O','U') ) 
					OR ISNUMERIC(SUBSTRING(@SEDOL,2,1))=1 )
		    		AND ( ( SUBSTRING(@SEDOL,3,1) between 'B' and 'Z' AND SUBSTRING(@SEDOL,3,1) not in ('E','I','O','U') ) 
					OR ISNUMERIC(SUBSTRING(@SEDOL,3,1))=1 )
		    		AND ( ( SUBSTRING(@SEDOL,4,1) between 'B' and 'Z' AND SUBSTRING(@SEDOL,4,1) not in ('E','I','O','U') ) 
					OR ISNUMERIC(SUBSTRING(@SEDOL,4,1))=1 )
		    		AND ( ( SUBSTRING(@SEDOL,5,1) between 'B' and 'Z' AND SUBSTRING(@SEDOL,5,1) not in ('E','I','O','U') ) 
					OR ISNUMERIC(SUBSTRING(@SEDOL,5,1))=1 )
		    		AND ( ( SUBSTRING(@SEDOL,6,1) between 'B' and 'Z' AND SUBSTRING(@SEDOL,6,1) not in ('E','I','O','U') ) 
					OR ISNUMERIC(SUBSTRING(@SEDOL,6,1))=1 )
		    		AND ( ISNUMERIC(SUBSTRING(@SEDOL,7,1))=1 ) --checkdigit always numeric
					))) --new style alphanumeric sedol
		)
		goto TheEnd
		/*****Check for errors*****/ select/*sp_password*/ @return=@@error if (@return<>0) goto TheEnd
	if((
		   	1* 
			case 	when substring(@SEDOL,1,1) between '0' and '9' then cast(substring(@SEDOL,1,1) as int)
				when substring(@SEDOL,1,1) between 'B' and 'Z' then ascii(substring(@SEDOL,1,1))-55
			else	-1 end
		+	3* 
			case 	when substring(@SEDOL,2,1) between '0' and '9' then cast(substring(@SEDOL,2,1) as int)
				when substring(@SEDOL,2,1) between 'B' and 'Z' then ascii(substring(@SEDOL,2,1))-55
			else	-1 end
		+	1* 
			case 	when substring(@SEDOL,3,1) between '0' and '9' then cast(substring(@SEDOL,3,1) as int)
				when substring(@SEDOL,3,1) between 'B' and 'Z' then ascii(substring(@SEDOL,3,1))-55
			else	-1 end
		+	7* 
			case 	when substring(@SEDOL,4,1) between '0' and '9' then cast(substring(@SEDOL,4,1) as int)
				when substring(@SEDOL,4,1) between 'B' and 'Z' then ascii(substring(@SEDOL,4,1))-55
			else	-1 end
		+	3* 
			case 	when substring(@SEDOL,5,1) between '0' and '9' then cast(substring(@SEDOL,5,1) as int)
				when substring(@SEDOL,5,1) between 'B' and 'Z' then ascii(substring(@SEDOL,5,1))-55
			else	-1 end
		+	9* 
			case 	when substring(@SEDOL,6,1) between '0' and '9' then cast(substring(@SEDOL,6,1) as int)
				when substring(@SEDOL,6,1) between 'B' and 'Z' then ascii(substring(@SEDOL,6,1))-55
			else	-1 end
		+	1* 
			case 	when substring(@SEDOL,7,1) between '0' and '9' then cast(substring(@SEDOL,7,1) as int)
				when substring(@SEDOL,7,1) between 'B' and 'Z' then ascii(substring(@SEDOL,7,1))-55
			else	-1 end
	)%10 = 0)		/* TOTAL MUST BE DIVISIBLE BY 10 */
	begin
		set @return = 1
		goto TheEnd
	end
		/*****Check for errors*****/ select/*sp_password*/ @return=@@error if (@return<>0) goto TheEnd
TheEnd:
	RETURN (@return)
END




