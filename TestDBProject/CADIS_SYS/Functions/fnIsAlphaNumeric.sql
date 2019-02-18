CREATE FUNCTION [cadis_sys].[fnIsAlphaNumeric] (@c char)  
RETURNS int AS  
BEGIN 
	declare @return int
	if (upper(@c) between 'A' and 'Z') or (@c between '0' and '9')
		set @return=1
	else
		set @return=0
	return (@return)
END
