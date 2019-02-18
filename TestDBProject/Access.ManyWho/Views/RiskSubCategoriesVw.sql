CREATE VIEW [Access.ManyWho].[RiskSubCategoriesVw]
	AS 
SELECT
	c.SubCategoryId AS SubCategoryId
	,c.SubCategory AS RiskSubCategory
	,c.CategoryId AS RiskCategoryId
	,pa.PersonsName AS RiskOwner
	,pa.PersonId AS RiskOwnerId
	,c.RiskAppetite AS RiskAppetite
  FROM [Risk].[SubCategories] c INNER JOIN
  [Risk].[SubCategoryRoleOwners] cro ON cro.SubCategoryId = c.SubCategoryId
  INNER JOIN [Access.ManyWho].PersonsActiveVw  pa ON pa.AssignedRoleId = cro.RoleId
