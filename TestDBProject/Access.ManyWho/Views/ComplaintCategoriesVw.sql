

CREATE VIEW [Access.ManyWho].[ComplaintCategoriesVw]
AS
SELECT cc.CategoryId 
	 , cc.Category
  FROM [Compliance].[ComplaintCategories] cc
