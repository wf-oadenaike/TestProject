CREATE VIEW [Compliance].[ExpensesExtractReadOnlyVw]
AS
	SELECT  
		Gift.[ExpenseId]
      ,Gift.[ExpenseReference]
      ,Gift.[CurrencyCode]
      ,Gift.[ExpenseAmount]
      ,Gift.[ExpenseCategory]
	  ,CONVERT( Date, Gift.[ExpenseIncurredDate],103) ExpenseIncurredDate
      ,Gift.[Description]
      ,Gift.[GivenOrReceived]
      ,Gift.[GiftOrEntertainment]
      ,CASE WHEN Gift.[ExpenseApproved] = 1 Then 'Yes'
			Else 'No'
			End ExpenseApproved
       ,App.PersonsName AS ApprovedBy
      ,Gift.[ComplianceComments]
      , ExpenseRel.PersonsName AS ExpenseRelatesTo
	  ,Gift.[LastName]
      ,Gift.[FirstName]
      ,Gift.[Title]
      ,Gift.[AccountName]
      ,Own.PersonsName As AccountOwner
	  ,Created.PersonsName as CreatedBy
      ,Gift.[ExpenseCreationDate]
      ,Gift.[ExpenseModifiedDate]
	FROM [Compliance].[GiftEntertainmentExpenses] Gift
	LEFT OUTER JOIN [Core].[Persons] App
	ON App.PersonId = Gift.ApprovedByPersonId
	LEFT OUTER JOIN [Core].[Persons] ExpenseRel
	ON ExpenseRel.PersonId = Gift.RelatesToPersonId
	LEFT OUTER JOIN [Core].[Persons] Own
	ON Own.PersonId = Gift.AccountOwnerPersonId
	LEFT OUTER JOIN [Core].[Persons] Created
	ON Created.PersonId = Gift.CreatedByPersonId;
