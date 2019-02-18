
CREATE VIEW [Access.ManyWho].[WhistleblowingVw]
	AS
	SELECT   wb.WhistleblowingId
	       , wb.RaisedByPersonId
	       , wb.RaisedDate
	       , wb.ReviewedByPersonId
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
		;
