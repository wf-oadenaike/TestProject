CREATE TABLE [Product.Governance].[ProductGovStageQuestions] (
    [ProductGovStageQuestionId]    INT              IDENTITY (1, 1) NOT NULL,
    [ProductGovStageId]            INT              NOT NULL,
    [QuestionNumber]               SMALLINT         NOT NULL,
    [QuestionText]                 VARCHAR (128)    NOT NULL,
    [Response]                     VARCHAR (2048)   NULL,
    [EvidenceFolderLink]           VARCHAR (2000)   NULL,
    [WorkflowVersionGUID]          UNIQUEIDENTIFIER NOT NULL,
    [JoinGUID]                     UNIQUEIDENTIFIER NOT NULL,
    [QuestionCreationDatetime]     DATETIME         CONSTRAINT [DF_PGSQ_QCDT] DEFAULT (getdate()) NOT NULL,
    [QuestionLastModifiedDatetime] DATETIME         CONSTRAINT [DF_PGSQ_QLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKProductGovStageQuestions] PRIMARY KEY CLUSTERED ([ProductGovStageId] ASC, [QuestionNumber] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIProductGovStageQuestions]
    ON [Product.Governance].[ProductGovStageQuestions]([ProductGovStageQuestionId] ASC);

