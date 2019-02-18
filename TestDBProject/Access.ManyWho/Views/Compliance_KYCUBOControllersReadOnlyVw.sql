




CREATE VIEW [Access.ManyWho].[Compliance_KYCUBOControllersReadOnlyVw]
		AS 
	SELECT
		K.UBOControllersID,
		K.Name,
		K.ChecklistID,  
		C.Name as ChecklistName,
		K.PersonType,
		K.Controller,
		K.IsActive,
		K.Details,
		K.JoinGUID,
		K.CADIS_SYSTEM_INSERTED,
        K.CADIS_SYSTEM_UPDATED,
        K.CADIS_SYSTEM_CHANGEDBY
	FROM [dbo].[Compliance_KYCUBOControllers]  K


	INNER JOIN [dbo].[Compliance_KYCChecklist] C
	ON K.ChecklistID = C.ChecklistID



