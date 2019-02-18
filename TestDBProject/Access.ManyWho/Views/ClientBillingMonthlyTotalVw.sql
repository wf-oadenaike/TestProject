CREATE VIEW [Access.ManyWho].[ClientBillingMonthlyTotalVw]
	AS 
SELECT
       YEAR(DateAdd(m,-1,ClientBillingCreationDatetime))*100 + MONTH(DateAdd(m,-1,ClientBillingCreationDatetime)) as CreatedYearMonth
     , MONTH(DateAdd(m,-1,ClientBillingCreationDatetime)) as CreatedMonthNum
	 , YEAR(DateAdd(m,-1,ClientBillingCreationDatetime)) as CreatedYear
     , LEFT(DATENAME ( MONTH , DateAdd(m,-1,ClientBillingCreationDatetime) ),3) + ' ' + CAST(YEAR(DateAdd(m,-1,ClientBillingCreationDatetime)) AS CHAR(4)) as CreatedMonth
	 , FORMAT(SUM (ISNULL(cb.Amount,0)),'#,0.00') as FormattedTotalAmount
	 , FORMAT(SUM (ISNULL(cb.VATAmount,0)),'#,0.00') as FormattedTotalVATAmount
	 , FORMAT ((SUM (ISNULL(cb.Amount,0)) + SUM (ISNULL(cb.VATAmount,0))),'#,0.00') as FormattedTotalGrossAmount
FROM [Sales].[ClientBilling] cb
GROUP BY MONTH(DateAdd(m,-1,ClientBillingCreationDatetime)), YEAR(DateAdd(m,-1,ClientBillingCreationDatetime)), LEFT(DATENAME ( MONTH , DateAdd(m,-1,ClientBillingCreationDatetime) ),3) + ' ' + CAST(YEAR(DateAdd(m,-1,ClientBillingCreationDatetime)) AS CHAR(4))

;
