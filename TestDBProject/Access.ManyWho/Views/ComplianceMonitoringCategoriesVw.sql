CREATE VIEW [Access.ManyWho].[ComplianceMonitoringCategoriesVw]
	AS 
SELECT
	  MonitoringCategoryId
	, MonitoringType
	, CategoryName
    , MonitoringFrequency
	, FrequencyMonths
	, FrequencyStartMonth
	, ISNULL(DueDateOffSet,0) as DueDateOffSet
	, DocumentationURL
	, SubmittedByPersonId
	, JoinGUID
	, MonitoringCategoryCreationDate
	, MonitoringCategoryLastModifiedDate
  FROM [Compliance].[MonitoringCategories]
  ;
