
CREATE VIEW [Access.ManyWho].[TrainingTypesVw]
	AS
	SELECT   tt.TrainingTypeId
	       , tt.TrainingType
		   , tt.JoinGUID
		   , tt.TrainingTypeCreationDate
	       , tt.TrainingTypeLastModifiedDate
	FROM [Compliance].[TrainingTypes] tt
	
		;
