CREATE TABLE [dbo].[Risk_Ratings] (
    [RiskRatingsId]          SMALLINT      IDENTITY (1, 1) NOT NULL,
    [RatingsScore]           SMALLINT      NULL,
    [RiskTitle]              VARCHAR (500) NOT NULL,
    [RatingsType]            VARCHAR (500) NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKRiskRatingsId] PRIMARY KEY CLUSTERED ([RiskRatingsId] ASC) WITH (FILLFACTOR = 80)
);

