
CREATE VIEW [Access.ManyWho].[WhistleblowingReadOnlyVw]
	AS
	SELECT   wb.WhistleblowingId
	       , wb.RaisedByPersonId
		   , rp.PersonsName as RaisedBy
	       , wb.RaisedDate
	       , wb.ReviewedByPersonId
		   , rep.PersonsName as ReviewedBy
	       , wb.ReviewedDate
	       , wb.Summary
		   , wb.Comments
	       , wb.Status
	       , wb.EmployeeNotifiedYesNo
		   , wb.AnonymousConcernYesNo
		   , wb.ConcernAgainstComplianceYesNo
	       , wb.DocumentationFolderLink
	       , wb.JoinGUID	
	       , wb.WhistleblowingCreationDate
	       , wb.WhistleblowingLastModifiedDate
	FROM [Organisation].[Whistleblowing] wb
	LEFT OUTER JOIN Core.Persons rp
		ON (wb.RaisedByPersonId = rp.PersonId)
	LEFT OUTER JOIN Core.Persons rep
		ON (wb.ReviewedByPersonId = rep.PersonId)
		;
