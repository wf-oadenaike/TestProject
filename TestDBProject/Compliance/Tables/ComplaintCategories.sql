CREATE TABLE [Compliance].[ComplaintCategories] (
    [CategoryId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [Category]   VARCHAR (128) NOT NULL,
    CONSTRAINT [PKComplaintCategoryId] PRIMARY KEY CLUSTERED ([CategoryId] ASC)
);

