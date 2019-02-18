
CREATE VIEW [Access.ManyWho].[ProductGovStageQuestionsVw]
	AS SELECT pgsq.ProductGovStageQuestionId
			, pgsq.ProductGovStageId
			, pgsq.QuestionNumber
			, pgsq.QuestionText
			, pgsq.Response
			, pgsq.EvidenceFolderLink
			, pgsq.WorkflowVersionGUID
			, pgsq.JoinGUID
			, pgsq.QuestionCreationDatetime
			, pgsq.QuestionLastModifiedDatetime
	 FROM [Product.Governance].[ProductGovStageQuestions] pgsq
	 ;
