
CREATE VIEW [Access.ManyWho].[TrainingStatusesVw]
	AS
	SELECT   ts.TrainingStatusId
	       , ts.TrainingStatus
	FROM [Compliance].[TrainingStatuses] ts
	
		;
