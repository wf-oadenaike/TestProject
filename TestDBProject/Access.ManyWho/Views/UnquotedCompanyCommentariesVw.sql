CREATE VIEW [Access.ManyWho].[UnquotedCompanyCommentariesVw]
	AS
SELECT [UnquotedCompanyCommentaryId]
      ,[UnquotedCompanyStage]
      ,[UnquotedCompanyId]
      ,[Commentary]
      ,[CommentaryByPersonId]
	  ,[p].[EmployeeBK] AS [CommentaryBySalesforceUserId]
      ,[CommentaryByRoleId]
	  ,[JoinGUID]
	  ,[CommentaryCreatedDate]
	  ,[CommentaryLastModifiedDate]
  FROM [Organisation].[UnquotedCompanyCommentaries] uc
  INNER JOIN [Core].[Persons] p ON uc.[CommentaryByPersonId] = p.PersonId
