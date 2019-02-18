CREATE FUNCTION [cadis_sys].[fnIsAlpha] (@c char)  
RETURNS int AS  
BEGIN 
	declare @return int
	if (upper(@c) between 'A' and 'Z')
		set @return=1
	else
		set @return=0
	return (@return)
END
