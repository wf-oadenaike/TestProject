
CREATE VIEW [Access.ManyWho].[GDPRRequestRegisterReadOnlyVw]  
 AS 

 SELECT 
   gdpr.GDPRRequestID
   , gdpr.RelatedPersonName
   , gdpr.SubmittedByPersonID
   , sb.PersonsName AS SubmittedBy
   , gdpr.Summary
   , gdpr.[Description]
   , gdpr.JoinGUID
   , gdpr.CADIS_SYSTEM_INSERTED   
   , gdpr.CADIS_SYSTEM_UPDATED   
   , gdpr.CADIS_SYSTEM_CHANGEDBY 

FROM [dbo].[HR_GDPRRequestRegister] gdpr
LEFT OUTER JOIN [Core].[Persons] sb
ON sb.PersonID = gdpr.SubmittedByPersonID


