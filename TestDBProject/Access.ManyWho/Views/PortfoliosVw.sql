
CREATE VIEW [Access.ManyWho].[PortfoliosVw]
	AS SELECT [SHORT_NAME] as PortfolioCode
	        , [LONG_NAME] as PortfolioName
	        , [LONG_NAME] as PortfolioDescription
	        , [CADIS_SYSTEM_INSERTED] as PortfolioCreationDate
	FROM [dbo].[T_MASTER_FND]

;
