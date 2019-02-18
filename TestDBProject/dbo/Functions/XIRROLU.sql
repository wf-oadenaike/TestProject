create function dbo.XIRROLU(
@d datetime,
@GUID varchar(128)
) returns decimal(18,10)
as
begin

/*
USAGE: select @IRR = dbo.xirr(null, guid)
select @IRR IRR, @IRR * 100 'IRR %'

Note: Leave the first parameter (date) null if you wish to see the XIRR calculated as
of the maximum date in the dataset provided else provide a specific date to see
the XIRR calculated as the given date.

Created By: Ankeet Shah
Created On: 7/16/2008

*/
IF @d is null
SELECT @d = max(d) from IncomeTable

declare @irrPrev float set @irrPrev = 0
declare @irr float set @irr = -0.1
declare @PresentValuePrev float
declare @PresentValue float

set @PresentValuePrev = ( select sum(amt) from XIRRTempData where guid = @GUID )
set @PresentValue = (select sum(amt/power(1e0+@irr,cast(dt-@d as float)/360)) from XIRRTempData where guid = @GUID )

while abs(@PresentValue) >= 0.0001
begin
declare @t float

set @t = @irrPrev
set @irrPrev = @irr
set @irr = @irr + (@t-@irr)*@PresentValue/(@PresentValue-@PresentValuePrev)
set @PresentValuePrev = @PresentValue
set @PresentValue = (select sum(amt/power(1e0+@irr,cast(dt-@d as float)/365)) from XIRRTempData where guid = @GUID )
end

return @irr
end
