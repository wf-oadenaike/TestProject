

CREATE VIEW [Access.ManyWho].[ControlLogCategoriesVw]
	AS SELECT [ControlLogCategoryId],
			  [CategoryName],
			  [CategoryDescription]
	 FROM [Audit].[ControlLogCategories]
	 ;
