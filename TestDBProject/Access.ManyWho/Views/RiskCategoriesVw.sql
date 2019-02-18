CREATE VIEW [Access.ManyWho].[RiskCategoriesVw]
	AS 
SELECT
	c.CategoryId AS RiskCategoryId
	,c.Category AS RiskCategory
	
  FROM [Risk].[Categories] c
