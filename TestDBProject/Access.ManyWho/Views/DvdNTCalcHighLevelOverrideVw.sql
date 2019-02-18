CREATE VIEW [Access.ManyWho].[DvdNTCalcHighLevelOverrideVw]
	AS 
SELECT [FUND_SHORT_NAME]
      ,[Qtr]
      ,[DATE]
      ,[NetIncome]
      ,[UnitsInIssue]
	  ,[PrevDvdRate]
      ,[DvdRate]
      ,[NTFAReconDiff]
      ,[OverrideNetIncome]
      ,[OverrideUnitsInIssue]
	  ,[OverrideDvdChangeReasonId]
	  ,cr.[DvdChangeReason] as OverrideDvdChangeReason
      ,[OverrideCommentary]
      ,[SubmittedByPersonId]
	  ,p.PersonsName as SubmittedBy
	  ,(SELECT SUM(DvdRate) 
	    FROM [Investment].[DvdNTCalcHighLevelOverride] co1
		WHERE SUBSTRING(CAST(YEAR(getdate()) as VARCHAR),3,2) = substring(co.Qtr,4,2) AND co1.FUND_SHORT_NAME = co.FUND_SHORT_NAME AND co1.IsActive = 1) as TotalDvdRate
      ,[IsActive]
      ,[JoinGUID]
      ,[DvdNTCalcHighLevelOverrideCreationDatetime]
      ,[DvdNTCalcHighLevelOverrideLastModifiedDatetime]
  FROM [Investment].[DvdNTCalcHighLevelOverride] co
  LEFT OUTER JOIN [Investment].[DvdChangeReasons] cr
  ON co.OverrideDvdChangeReasonId = cr.DvdChangeReasonId
  LEFT OUTER JOIN [Core].[Persons] p
  ON p.PersonId = co.SubmittedByPersonId;


