
CREATE VIEW  [Reporting].[vw_KPIFactAll12Months]

AS

--Using Select * to Bring in any new addition to the view 
select *  from Reporting.KPIFactAllVw
where KPIDate  BETWEEN DATEADD(Year,-1,GETDATE()) AND GetDATE()
