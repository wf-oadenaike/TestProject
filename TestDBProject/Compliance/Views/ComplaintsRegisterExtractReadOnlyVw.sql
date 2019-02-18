CREATE VIEW [Compliance].[ComplaintsRegisterExtractReadOnlyVw]
AS

With EventDetails AS (
							SELECT
							ComplaintRegisterId,
							STUFF((
							  SELECT 
							  '; ' + CONVERT(VARCHAR(31),CRE.EventDate) + ' - ' + CET.ComplaintEventType + ' - ' + CRE.EventDetails
								  FROM     [Compliance].[ComplaintsRegisterEvents]  AS CRE
								  INNER JOIN  [Compliance].[ComplaintEventTypes] CET ON CET.ComplaintEventTypeId = CRE.ComplaintEventTypeId
								  WHERE  (CRE.ComplaintRegisterId = CR.ComplaintRegisterId)
										  ORDER BY CRE.EventDate DESC
								   FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'
								   ),1,1,'') AS EventMessages
							FROM [Compliance].[ComplaintsRegister] CR
							GROUP BY ComplaintRegisterId	
						
						)

SELECT 	  
	  Register.ComplaintRegisterId
	, Register.ComplainantClientName
	, Register.PartyComplaintAgainst
	, Register.ReferenceNumbers
	, Register.ReportedBy
	, P.PersonsName AS ComplaintRecordedBy
	, Register.FundsAffected
	, Register.ReportedToWIMDate
	, Register.ComplaintDetails
	, Register.ComplaintDate
	, Register.CompOrRestitutionSummary
	, Register.RootCauseDetails
	, Register.RemedialAction
	, Register.MitigationSteps
	, CASE WHEN Register.ComplaintClosed =1 THEN 'Yes'
			ELSE 'No'
			END ComplaintClosed
	, Register.DocumentationFolderLink
	, Register.ComplaintCreationDate
	, Register.ComplaintLastModifiedDate
	, Categories.Category AS ComplaintCategory
	, RootCause.RootCause
	, EventDetails.EventMessages AS ComplaintEvents
	, Register.ComplaintStatus
	, Register.[ExternalPartyFwdTo]
	, ThirdParty.ThirdPartyName
FROM [Compliance].[ComplaintsRegister] Register
INNER JOIN Core.Persons P
ON (Register.RecordedByPersonId = P.PersonId)
LEFT OUTER JOIN EventDetails
ON EventDetails.ComplaintRegisterId = Register.ComplaintRegisterId
INNER JOIN [Compliance].[ComplaintCategories] Categories
ON Register.ComplaintCategoryId = Categories.CategoryId
LEFT OUTER JOIN [Compliance].[ComplaintRootCauses] RootCause
ON RootCause.RootCauseId = Register.ComplaintRootCauseId
LEFT OUTER JOIN [Core].[ThirdParties] ThirdParty
ON ThirdParty.[ThirdPartyId] = Register.ThirdPartyId
;
