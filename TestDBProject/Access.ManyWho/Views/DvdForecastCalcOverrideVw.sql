CREATE VIEW [Access.ManyWho].[DvdForecastCalcOverrideVw]
	AS 
  SELECT [DvdForecastCalcOverrideId]
	  ,[EDM_SEC_ID]
	  ,[FUND_SHORT_NAME]
	  ,[SECURITY_NAME]
	  ,[Qtr]
	  ,[EX_DATE]
	  ,[PrevDvdValue]	
	  ,[DVD_VALUE]
	  ,[POSITION]
	  ,[DIVIDEND_CCY]
	  ,[WITHHOLDING_TAX]
	  ,[OverrideExDate]
	  ,[OverrideDvdValue]
	  ,[OverrideSpecialCumShares]
	  ,[GrossDvdValue]
	  ,[NetDvdValue]
	  ,[SpecialCumTrades]
	  ,[PrevTotalNetDvd]
	  ,[TotalNetDvd]
	  ,[NTCustodyNetAmountBase]
	  ,[NTCustodyReconDiff]
	  ,[NTCustodyDvdChangeReasonId]
	  ,ccr.[DvdChangeReason] as NTCustodyDvdChangeReason
	  ,[NTCustodyCommentary]
	  ,[UseNTCustodyValue]
	  ,[NTFAValueBase]
	  ,[NTFAReconDiff]
	  ,[NTFACommentary]
	  ,[UseNTFAValue]
	  ,[SubmittedByPersonId]
	  ,p.PersonsName as SubmittedBy
	  ,[OverrideDvdChangeReasonId]
	  ,ocr.[DvdChangeReason] as OverrideDvdChangeReason
	  ,[OverrideCommentary]
	  ,[IsActive]
	  ,[JoinGUID]
	  ,[DvdForecastCalcOverrideCreationDatetime]
	  ,[DvdForecastCalcOverrideLastModifiedDatetime]
  FROM [Investment].[DvdForecastCalcOverride] co
  LEFT OUTER JOIN [Investment].[DvdChangeReasons] ccr
  ON co.NTCustodyDvdChangeReasonId = ccr.DvdChangeReasonId
  LEFT OUTER JOIN [Investment].[DvdChangeReasons] ocr
  ON co.OverrideDvdChangeReasonId = ocr.DvdChangeReasonId
  LEFT OUTER JOIN [Core].[Persons] p
  ON p.PersonId = co.SubmittedByPersonId
  WHERE co.IsActive = 1;
