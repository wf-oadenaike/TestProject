CREATE TABLE [Organisation].[CompanyBusinessActivityTypes] (
    [BusinessActivityTypeId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [BusinessActivityType]   VARCHAR (128) NOT NULL,
    CONSTRAINT [PKCompanyBusinessActivityTypes] PRIMARY KEY CLUSTERED ([BusinessActivityTypeId] ASC)
);

