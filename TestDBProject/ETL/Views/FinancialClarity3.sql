
Create view ETL.FinancialClarity3 as 
SELECT  'Market_Activity_2015__c' as type,  
 CONVERT(VARCHAR(4),DATEPART(yy,convert(date, As_at_date, 103))) + '-' + 
 RIGHT('0' + CONVERT(VARCHAR(2),DATEPART(mm,convert(date, As_at_date, 103))),2) + '-' + RIGHT('0' + CONVERT(VARCHAR(2),DATEPART(dd,convert(date, As_at_date, 103))),2) AS [As_at_Date],
[CADIS_SYSTEM_CHANGEDBY],
CADIS_SYSTEM_INSERTED, 
CADIS_SYSTEM_LASTMODIFIED, 
CADIS_SYSTEM_PRIORITY, 
CADIS_SYSTEM_TIMESTAMP, 
CADIS_SYSTEM_UPDATED, 
ISNULL([Global_Equity_Income_Market_Gross_Sales],0) AS [Global_Equity_Income_Market_Gross_Sales],
ISNULL([Global_Equity_Income_Market_Net_Sales],0) AS [Global_Equity_Income_Market_Net_Sales],
ISNULL([Global_Equity_Income_Own_Gross_Sales],0) AS [Global_Equity_Income_Own_Gross_Sales],
ISNULL([Global_Equity_Income_Own_Net_Sales],0) AS [Global_Equity_Income_Own_Net_Sales],
MTX_ACCOUNT_SIV_ID, 
Matrix_Outlet_ID, 
MONTH(convert(date, As_at_date, 103)) AS Month,
ISNULL([Outlet_Market_Gross_Sales],0) AS [Outlet_Market_Gross_Sales],
ISNULL([Outlet_Market_Net_Sales],0) AS [Outlet_Market_Net_Sales],
ISNULL([Outlet_Own_Gross_Sales],0) AS [Outlet_Own_Gross_Sales],
ISNULL([Outlet_Own_Net_Sales],0) AS [Outlet_Own_Net_Sales],

m.AccSalesforceId as [SalesforceAccountId],

ISNULL([UK_All_Companies_Market_Gross_Sales],0) AS [UK_All_Companies_Market_Gross_Sales],
ISNULL([UK_All_Companies_Market_Net_Sales],0) AS [UK_All_Companies_Market_Net_Sales],
ISNULL([UK_All_Companies_Own_Gross_Sales],0) AS [UK_All_Companies_Own_Gross_Sales],
ISNULL([UK_All_Companies_Own_Net_Sales],0) AS [UK_All_Companies_Own_Net_Sales],

ISNULL([UK_Equity_Income_Market_Gross_Sales],0) AS [UK_Equity_Income_Market_Gross_Sales],
ISNULL([UK_Equity_Income_Market_Net_Sales],0) AS [UK_Equity_Income_Market_Net_Sales],
ISNULL([UK_Equity_Income_Own_Gross_Sales],0) AS [UK_Equity_Income_Own_Gross_Sales],
ISNULL([UK_Equity_Income_Own_Net_Sales],0) AS [UK_Equity_Income_Own_Net_Sales],

ISNULL([UK_Equity_and_Bond_Income_Market_Gross_Sales],0) AS [UK_Equity_and_Bond_Income_Market_Gross_Sales],
ISNULL([UK_Equity_and_Bond_Income_Market_Net_Sales],0) AS [UK_Equity_and_Bond_Income_Market_Net_Sales],
ISNULL([UK_Equity_and_Bond_Income_Own_Gross_Sales],0) AS [UK_Equity_and_Bond_Income_Own_Gross_Sales],
ISNULL([UK_Equity_and_Bond_Income_Own_Net_Sales],0) AS [UK_Equity_and_Bond_Income_Own_Net_Sales],

ISNULL([Specialist_Market_Gross_Sales],0) AS [Specialist_Market_Gross_Sales],
ISNULL([Specialist_Market_Net_Sales],0) AS [Specialist_Market_Net_Sales],
ISNULL([Specialist_Own_Gross_Sales],0) AS [Specialist_Own_Gross_Sales],
ISNULL([Specialist_Own_Net_Sales],0) AS [Specialist_Own_Net_Sales],


'Z' + convert(nvarchar(50),newid())  as id_external__c,
replace('/services/data/v37.0/sobjects/Market_Activity_2015__c/id_external__c/X' + m.AccSalesforceId + '_' 
+ cast(convert(date, As_at_date, 103) as varchar(10)),'-','')  as url,
'PATCH' as method
FROM 


[Staging.Salesforce.BP].[MxAccountExtract] m
join 
[Staging.Matrix].[FinancialClarity] f
on f.MTX_ACCOUNT_SIV_ID=m.[AccSivId]
where m.AccSalesforceId is not null



