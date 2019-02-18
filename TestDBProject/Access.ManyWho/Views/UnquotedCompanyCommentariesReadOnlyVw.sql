CREATE VIEW [Access.ManyWho].[UnquotedCompanyCommentariesReadOnlyVw]
	AS
SELECT [UnquotedCompanyCommentaryId]
      ,[UnquotedCompanyStage]
      ,[UnquotedCompanyId]
      ,[Commentary]
      ,[CommentaryByPersonId]
	  ,p.EmployeeBK AS [CommentaryBySalesforceUserId]
	  ,p.PersonsName as CommentaryBy
      ,[CommentaryByRoleId]
	  ,[JoinGUID]
	  ,[CommentaryCreatedDate]
	  ,[CommentaryLastModifiedDate]
  FROM [Organisation].[UnquotedCompanyCommentaries] uc
  INNER JOIN [Core].[Persons] p ON uc.[CommentaryByPersonId] = p.PersonId
