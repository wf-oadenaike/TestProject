CREATE VIEW [Access.ManyWho].[ClientBillingReadOnlyVw]
	AS 
SELECT
	   cb.ClientBillingId
	 , cr.ClientId
	 , cr.ClientName
	 , cb.MandateId
	 , m.MandateName
	 , cb.InvoiceDueDate
	 , cb.InvoiceReceivedDate
	 , cb.Amount
	 , FORMAT(cb.Amount,'#,0.00') as FormattedAmount
	 , cb.VATAmount as VATAmount
	 , FORMAT(cb.VATAmount,'#,0.00') as FormattedVATAmount
	 , (cb.Amount + ISNULL(cb.VATAmount,0)) as GrossAmount	 
	 , FORMAT((cb.Amount + ISNULL(cb.VATAmount,0)),'#,0.00') as FormattedGrossAmount	 
	 , cb.GrossAmountReceived
	 , FORMAT(cb.GrossAmountReceived,'#,0.00') as FormattedGrossAmountReceived
	 , cb.SubmittedByPersonId
	 , sp.PersonsName as SubmittedBy
	 , cb.SubmittedDate
	 , cb.ReviewedByPersonId
	 , rp.PersonsName as ReviewedBy
	 , cb.ReviewedDate
	 , cb.StatusId
	 , cbs.ClientBillingStatus
	 , cb.PaymentDueDate
	 , cb.PaymentReceivedDate
	 , cb.OpsTaskJiraKey
	 , cb.ReconTaskJiraKey
	 , cb.IsActive
	 , LEFT(DATENAME ( MONTH , DateAdd(m,-1,ClientBillingCreationDatetime) ),3) + ' ' + CAST(YEAR(DateAdd(m,-1,ClientBillingCreationDatetime)) AS CHAR(4)) as CreatedMonth
	 , cb.DocumentationFolderLink
     , cb.JoinGUID
     , cb.ClientBillingCreationDatetime
     , cb.ClientBillingLastModifiedDatetime
	 , cb.ReconParentJiraKey
  FROM [Sales].[ClientBilling] cb
  INNER JOIN [Investment].[Mandates] m
  ON m.MandateId = cb.MandateId
  INNER JOIN [Sales].[ClientRegister] cr
  ON m.ClientId = cr.ClientId
  INNER JOIN [Sales].[ClientBillingStatuses] cbs
  ON cb.StatusId = cbs.ClientBillingStatusId 
  INNER JOIN [Core].[Persons] sp
  ON cb.SubmittedByPersonId = sp.PersonId
  LEFT OUTER JOIN [Core].[Persons] rp
  ON cb.ReviewedByPersonId = rp.PersonId

  ;
