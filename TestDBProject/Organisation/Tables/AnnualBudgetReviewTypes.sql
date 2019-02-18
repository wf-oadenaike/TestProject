CREATE TABLE [Organisation].[AnnualBudgetReviewTypes] (
    [ReviewTypeId] INT           IDENTITY (1, 1) NOT NULL,
    [ReviewType]   VARCHAR (128) NOT NULL,
    CONSTRAINT [PKAnnualBudgetReviewTypes] PRIMARY KEY CLUSTERED ([ReviewTypeId] ASC)
);

