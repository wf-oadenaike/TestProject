
CREATE VIEW [Access.ManyWho].[FinanceAccountsVw]
	AS
	SELECT   nc.NominalCode
	       , nc.AccountName
		   , nc.AccountCategoryId
		   , ac.AccountCategory
	FROM [Finance].[AccountNominalCodes] nc
	LEFT OUTER JOIN [Finance].[AccountCategories] ac
	ON nc.AccountCategoryId = ac.AccountCategoryId
;
