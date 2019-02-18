CREATE view [Access.ManyWho].[InvestmentMarketCommentaryReadOnlyVw]
AS
-------------------------------------------------------------------------------------- 
-- Name: [Access.ManyWho].[InvestmentMarketCommentaryReadOnlyVw]
-- Object: View
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- Richard Dixon, 30/10/2017 DAP-1243
-- Returns view of investment market summary plus contributors and laggards
-- 
--------------------------------------------------------------------------------------
SELECT DISTINCT
		x.[CommentaryId]
      ,x.[CommentaryDate]
	  ,x.[CommentaryType]
      ,x.[WEIFCOD]
      ,x.[BenchMarkCOD]
      ,x.[WPCTCOD]
      ,x.[SharePriceClose]
      ,x.[NAVClose]
      ,x.[Commentary]

	  ,ec1_EIF.[SecurityName] as [Contrib1NameWIMEIF]
	  ,ec1_EIF.[SecurityValue] as [Contrib1ValueWIMEIF]
	  ,ec1_IFF.[SecurityName] as [Contrib1NameWIMIFF]
	  ,ec1_IFF.[SecurityValue] as [Contrib1ValueWIMIFF]


	  ,ec2_EIF.[SecurityName] as [Contrib2NameWIMEIF]
	  ,ec2_EIF.[SecurityValue] as [Contrib2ValueWIMEIF]
	  ,ec2_IIF.[SecurityName] as [Contrib2NameWIMIFF]
	  ,ec2_IIF.[SecurityValue] as [Contrib2ValueWIMIFF]

  	  ,ec3_EIF.[SecurityName] as [Contrib3NameWIMEIF]
	  ,ec3_EIF.[SecurityValue] as [Contrib3ValueWIMEIF]
	  ,ec3_IIF.[SecurityName] as [Contrib3NameWIMIFF]
	  ,ec3_IIF.[SecurityValue] as [Contrib3ValueWIMIFF]


  	  ,ec4_EIF.[SecurityName] as [Contrib4NameWIMEIF]
	  ,ec4_EIF.[SecurityValue] as [Contrib4ValueWIMEIF]
	  ,ec4_IIF.[SecurityName] as [Contrib4NameWIMIFF]
	  ,ec4_IIF.[SecurityValue] as [Contrib4ValueWIMIFF]


  	  ,ec5_EIF.[SecurityName] as [Contrib5NameWIMEIF]
	  ,ec5_EIF.[SecurityValue] as [Contrib5ValueWIMEIF]
	  ,ec5_IIF.[SecurityName] as [Contrib5NameWIMIFF]
	  ,ec5_IIF.[SecurityValue] as [Contrib5ValueWIMIFF]


      ,el1_EIF.[SecurityName] as [Laggard1NameWIMEIF]
      ,el1_EIF.[SecurityValue] as [Laggard1ValueWIMEIF]
      ,el1_IFF.[SecurityName] as [Laggard1NameWIMIFF]
      ,el1_IFF.[SecurityValue] as [Laggard1ValueWIMIFF]


      ,el2_EIF.[SecurityName] as [Laggard2NameWIMEIF]
      ,el2_EIF.[SecurityValue] as [Laggard2ValueWIMEIF]
      ,el2_IFF.[SecurityName] as [Laggard2NameWIMIFF]
      ,el2_IFF.[SecurityValue] as [Laggard2ValueWIMIFF]

      ,el3_EIF.[SecurityName] as [Laggard3NameWIMEIF]
      ,el3_EIF.[SecurityValue] as [Laggard3ValueWIMEIF]
      ,el3_IFF.[SecurityName] as [Laggard3NameWIMIFF]
      ,el3_IFF.[SecurityValue] as [Laggard3ValueWIMIFF]

      ,el4_EIF.[SecurityName] as [Laggard4NameWIMEIF]
      ,el4_EIF.[SecurityValue] as [Laggard4ValueWIMEIF]
      ,el4_IFF.[SecurityName] as [Laggard4NameWIMIFF]
      ,el4_IFF.[SecurityValue] as [Laggard4ValueWIMIFF]


      ,el5_EIF.[SecurityName] as [Laggard5NameWIMEIF]
      ,el5_EIF.[SecurityValue] as [Laggard5ValueWIMEIF]
      ,el5_IFF.[SecurityName] as [Laggard5NameWIMIFF]
      ,el5_IFF.[SecurityValue] as [Laggard5ValueWIMIFF]



      ,y.PersonsName as 'SubmittedBy'
      ,x.[DocumentationFolderLink]
      ,x.[JoinGUID]
      ,x.[CADIS_SYSTEM_INSERTED]
      ,x.[CADIS_SYSTEM_UPDATED]
      ,x.[CADIS_SYSTEM_CHANGEDBY]
      ,x.[CADIS_SYSTEM_PRIORITY]
      ,x.[CADIS_SYSTEM_TIMESTAMP]
      ,x.[CADIS_SYSTEM_LASTMODIFIED]

  FROM [Investment].[MarketCommentary] x
		join core.persons y
			on x.SubmittedByPersonId = y.personid

		left
		join [Investment].[MarketCommentaryEvents] ec1_EIF 
			on x.CommentaryId = ec1_EIF.CommentaryId
			and ec1_EIF.Rank = 1
			and ec1_EIF.EventType = 'Contributor'
			and ec1_EIF.Fund = 'WIMEIF'
		left
		join [Investment].[MarketCommentaryEvents] ec1_IFF 
			on x.CommentaryId = ec1_IFF.CommentaryId
			and ec1_IFF.Rank = 1
			and ec1_IFF.EventType = 'Contributor'
			and ec1_IFF.Fund = 'WIMIFF'


		left
		join [Investment].[MarketCommentaryEvents] ec2_EIF
			on x.CommentaryId = ec2_EIF.CommentaryId
			and ec2_EIF.Rank = 2
			and ec2_EIF.EventType = 'Contributor'
			and ec2_EIF.Fund = 'WIMEIF'
		left
		join [Investment].[MarketCommentaryEvents] ec2_IIF
			on x.CommentaryId = ec2_IIF.CommentaryId
			and ec2_IIF.Rank = 2
			and ec2_IIF.EventType = 'Contributor'
			and ec2_IIF.Fund = 'WIMIFF'


		left
		join [Investment].[MarketCommentaryEvents] ec3_EIF 
			on x.CommentaryId = ec3_EIF.CommentaryId
			and ec3_EIF.Rank = 3
			and ec3_EIF.EventType = 'Contributor'
			and ec3_EIF.Fund = 'WIMEIF'
		left
		join [Investment].[MarketCommentaryEvents] ec3_IIF 
			on x.CommentaryId = ec3_IIF.CommentaryId
			and ec3_IIF.Rank = 3
			and ec3_IIF.EventType = 'Contributor'
			and ec3_IIF.Fund = 'WIMIFF'

		left
		join [Investment].[MarketCommentaryEvents] ec4_EIF 
			on x.CommentaryId = ec4_EIF.CommentaryId
			and ec4_EIF.Rank = 4
			and ec4_EIF.EventType = 'Contributor'
			and ec4_EIF.Fund = 'WIMEIF'
		left
		join [Investment].[MarketCommentaryEvents] ec4_IIF 
			on x.CommentaryId = ec4_IIF.CommentaryId
			and ec4_IIF.Rank = 4
			and ec4_IIF.EventType = 'Contributor'
			and ec4_IIF.Fund = 'WIMIFF'


		left
		join [Investment].[MarketCommentaryEvents] ec5_EIF 
			on x.CommentaryId = ec5_EIF.CommentaryId
			and ec5_EIF.Rank = 5
			and ec5_EIF.EventType = 'Contributor'
			and ec5_EIF.Fund = 'WIMEIF'
		left
		join [Investment].[MarketCommentaryEvents] ec5_IIF 
			on x.CommentaryId = ec5_IIF.CommentaryId
			and ec5_IIF.Rank = 5
			and ec5_IIF.EventType = 'Contributor'
			and ec5_IIF.Fund = 'WIMIFF'

		left
		join [Investment].[MarketCommentaryEvents] el1_EIF
			on x.CommentaryId = el1_EIF.CommentaryId
			and el1_EIF.Rank = 1
			and el1_EIF.EventType = 'Laggard'
			and el1_EIF.Fund = 'WIMEIF'
		left
		join [Investment].[MarketCommentaryEvents] el1_IFF
			on x.CommentaryId = el1_IFF.CommentaryId
			and el1_IFF.Rank = 1
			and el1_IFF.EventType = 'Laggard'
			and el1_IFF.Fund = 'WIMIFF'
		
		left
		join [Investment].[MarketCommentaryEvents] el2_EIF
			on x.CommentaryId = el2_EIF.CommentaryId
			and el2_EIF.Rank = 2
			and el2_EIF.EventType = 'Laggard'
			and el2_EIF.Fund = 'WIMEIF'
		left
		join [Investment].[MarketCommentaryEvents] el2_IFF
			on x.CommentaryId = el2_IFF.CommentaryId
			and el2_IFF.Rank = 2
			and el2_IFF.EventType = 'Laggard'
			and el2_IFF.Fund = 'WIMIFF'
		
		left
		join [Investment].[MarketCommentaryEvents] el3_EIF
			on x.CommentaryId = el3_EIF.CommentaryId
			and el3_EIF.Rank = 3
			and el3_EIF.EventType = 'Laggard'
			and el3_EIF.Fund = 'WIMEIF'
		left
		join [Investment].[MarketCommentaryEvents] el3_IFF
			on x.CommentaryId = el3_IFF.CommentaryId
			and el3_IFF.Rank = 3
			and el3_IFF.EventType = 'Laggard'
			and el3_IFF.Fund = 'WIMIFF'
		
		left
		join [Investment].[MarketCommentaryEvents] el4_EIF
			on x.CommentaryId = el4_EIF.CommentaryId
			and el4_EIF.Rank = 4
			and el4_EIF.EventType = 'Laggard'
			and el4_EIF.Fund = 'WIMEIF'
		left
		join [Investment].[MarketCommentaryEvents] el4_IFF
			on x.CommentaryId = el4_IFF.CommentaryId
			and el4_IFF.Rank = 4
			and el4_IFF.EventType = 'Laggard'
			and el4_IFF.Fund = 'WIMIFF'
		
		left
		join [Investment].[MarketCommentaryEvents] el5_EIF
			on x.CommentaryId = el5_EIF.CommentaryId
			and el5_EIF.Rank = 5
			and el5_EIF.EventType = 'Laggard'
			and el5_EIF.Fund = 'WIMEIF'
		left
		join [Investment].[MarketCommentaryEvents] el5_IFF
			on x.CommentaryId = el5_IFF.CommentaryId
			and el5_IFF.Rank = 5
			and el5_IFF.EventType = 'Laggard'
			and el5_IFF.Fund = 'WIMIFF'
