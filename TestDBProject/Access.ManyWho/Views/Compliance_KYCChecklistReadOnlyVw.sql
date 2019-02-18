





CREATE VIEW [Access.ManyWho].[Compliance_KYCChecklistReadOnlyVw]
		AS 
	SELECT
       K.ChecklistID,
       K.Name,  
	   C.LegalEntityType,
	   D.CountryName as IncorporationCountry, 
	   D2.CountryName as JurisdictionCountry, 
	   B.FlowStatusName as Status,
	   K.ReviewDate,
	   K.NextReviewDate,
	   C3.RiskRatingName as IncorporationRiskScore,
	   C2.RiskRatingName as JurisdictionRiskScore,
	   KYL.RiskRatingName as LegalEntityRiskScore,
	   c4.RiskRatingName as PEPRiskScore,
       (C2.RiskRatingID + C3.RiskRatingID + KYL.RiskRatingID + C4.RiskRatingID) as TotalRiskScore,
	   CASE WHEN (C2.RiskRatingID + C3.RiskRatingID + KYL.RiskRatingID + C4.RiskRatingID) < 5 THEN 'Low' ELSE 'Medium / High' END AS TotalRiskRating,	  
	   A.PersonsName as ReviewedBy,
	   A2.PersonsName as SubmittedBy,
	    K.IsActive,
       K.JoinGUID,
       K.CADIS_SYSTEM_INSERTED,
       K.CADIS_SYSTEM_UPDATED,
       K.CADIS_SYSTEM_CHANGEDBY
   FROM [dbo].[Compliance_KYCChecklist]  K

   Left JOIN [dbo].[Compliance_KYCLegalEntityTypes] C
   ON K.LegalEntityTypeID = C.LegalEntityTypeID

   Left JOIN [dbo].[Compliance_KYCCountries] D
   ON K.IncorporationCountryID = D.CountryID

   Left JOIN [dbo].[Compliance_KYCCountries] D2
   ON K.JurisdictionCountryID = D2.CountryID
   
   Left JOIN [Core].[Persons] A
   ON K.ReviewedByPersonID = A.PersonID

   Left JOIN [Core].[Persons] A2
   ON K.SubmittedByPersonID = A2.PersonID

   Left JOIN [Core].[FlowStatus] B
   ON K.StatusID = B.FlowStatusId

   Left JOIN [dbo].[Compliance_KYCRiskRating] C2
   ON D2.RiskRatingID = C2.RiskRatingID

   Left JOIN [dbo].[Compliance_KYCRiskRating] C3
   ON D.RiskRatingID = C3.RiskRatingID

   Left JOIN [dbo].[Compliance_KYCRiskRating] KYL
   ON C.RiskRatingID = KYL.RiskRatingID

   Left join (select MAX(PoP.[RiskRatingID]) as MaxRatingID, K.[ChecklistID]
	   FROM [dbo].[Compliance_KYCChecklist] K
	   LEFT JOIN [dbo].[Compliance_KYCPEP] PEP ON PEP.ChecklistID = K.ChecklistID
	   LEFT JOIN [dbo].[Compliance_KYCPoliticalPosition] PoP ON PoP.PoliticalPositionID = PEP.PoliticalPositionID
	   GROUP BY  K.[ChecklistID]) ABCD ON K.[ChecklistID] = ABCD.[ChecklistID]

   Left Join [dbo].[Compliance_KYCRiskRating] C4 on ABCD.MaxRatingID = C4.RiskRatingID




