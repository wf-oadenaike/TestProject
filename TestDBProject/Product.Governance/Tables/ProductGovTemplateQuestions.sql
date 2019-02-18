CREATE TABLE [Product.Governance].[ProductGovTemplateQuestions] (
    [ProductGovTemplateId] INT           IDENTITY (1, 1) NOT NULL,
    [StageCategoryId]      SMALLINT      NOT NULL,
    [StageSectionId]       SMALLINT      NOT NULL,
    [QuestionNumber]       SMALLINT      NOT NULL,
    [QuestionText]         VARCHAR (128) NOT NULL,
    CONSTRAINT [PKProductGovTemplateQuestions] PRIMARY KEY CLUSTERED ([StageCategoryId] ASC, [QuestionNumber] ASC),
    CONSTRAINT [ProductGovTemplateQuestionsCategoryId] FOREIGN KEY ([StageCategoryId]) REFERENCES [Product.Governance].[ProductGovStageCategories] ([StageCategoryId]),
    CONSTRAINT [ProductGovTemplateQuestionsSectionId] FOREIGN KEY ([StageSectionId]) REFERENCES [Product.Governance].[ProductGovStageSections] ([StageSectionId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIProductGovTemplateQuestions]
    ON [Product.Governance].[ProductGovTemplateQuestions]([ProductGovTemplateId] ASC);

