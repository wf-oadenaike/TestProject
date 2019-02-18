




CREATE VIEW [Access.ManyWho].[Compliance_KYCPEPReadOnlyVw]
		AS 
	SELECT
       K.PEPID,
       K.ChecklistID,  
       A.Name as ChecklistName,
       K.FullName,
       C.PoliticalPositionName as PoliticalPosition,
       R.RiskRatingName as RiskRating,
	   K.IsActive,
	   K.PersonDetails,
       K.JoinGUID,
       K.CADIS_SYSTEM_INSERTED,
       K.CADIS_SYSTEM_UPDATED,
       K.CADIS_SYSTEM_CHANGEDBY
   FROM [dbo].[Compliance_KYCPEP]  K

   Left Outer  JOIN [dbo].[Compliance_KYCPoliticalPosition] C
   ON K.PoliticalPositionID = C.PoliticalPositionID

   Left Outer JOIN [dbo].[Compliance_KYCRiskRating] R
   ON C.RiskRatingID = R.RiskRatingID

    Left Outer JOIN [dbo].[Compliance_KYCChecklist] A
   ON K.ChecklistID = A.ChecklistID



