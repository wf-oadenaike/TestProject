
CREATE VIEW [Access.ManyWho].[FinanceAccountCategoriesVw]
	AS
	SELECT ac.AccountCategoryId
		 , ac.AccountCategory
	FROM [Finance].[AccountCategories] ac
	WHERE ac.AccountCategory != 'Coms, Tech and MDS'
;

