CREATE TABLE [Sales.BP].[Forecast] (
    [ForecastId]                   VARCHAR (25)    NOT NULL,
    [OwnerId]                      VARCHAR (25)    NOT NULL,
    [Subject]                      NVARCHAR (1000) NULL,
    [ActivityDate]                 DATETIME        NULL,
    [Type]                         VARCHAR (50)    NULL,
    [Status]                       VARCHAR (50)    NULL,
    [Priority]                     VARCHAR (50)    NULL,
    [AccountId]                    VARCHAR (25)    NULL,
    [Description]                  NVARCHAR (MAX)  NULL,
    [PlanActivityType]             VARCHAR (50)    NULL,
    [IsActive]                     BIT             NOT NULL,
    [ForecastCreationDatetime]     DATETIME        CONSTRAINT [DF_FORC_FORCCDT] DEFAULT (getdate()) NOT NULL,
    [ForecastLastModifiedDatetime] DATETIME        CONSTRAINT [DF_FORC_FORCLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKForecastId] PRIMARY KEY CLUSTERED ([ForecastId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDX_SBPF_1]
    ON [Sales.BP].[Forecast]([OwnerId] ASC, [IsActive] ASC)
    INCLUDE([ActivityDate], [Type], [Status], [AccountId], [Description]);


GO
CREATE NONCLUSTERED INDEX [NDX_ACCTID_Forecast]
    ON [Sales.BP].[Forecast]([AccountId] ASC, [OwnerId] ASC, [IsActive] ASC);

