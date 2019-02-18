CREATE FUNCTION [cadis_sys].[fnCRCValue] (@c char)  
RETURNS int AS  
BEGIN 
	declare @return int
	--valid inputs are alphanumeric ONLY
	if (@c between 'A' and 'Z') or (@c between '0' and '9')
	begin
		if (IsNumeric(@c)=1)
			set @return= cast(@c as int) --normal digits just take on their own value
		else
			set @return= ascii(@c)-55 --characters valued A=10, B=11 etc.
	end
	else
	begin
		set @return=-1
	end
	return (@return)
END
