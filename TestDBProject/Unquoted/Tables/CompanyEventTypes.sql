CREATE TABLE [Unquoted].[CompanyEventTypes] (
    [CompanyEventTypeId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [CompanyEventType]   VARCHAR (128) NOT NULL,
    CONSTRAINT [PKCompanyEventTypes] PRIMARY KEY CLUSTERED ([CompanyEventTypeId] ASC)
);

