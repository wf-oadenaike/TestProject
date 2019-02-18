CREATE TABLE [Core].[EmployeeInfoHistory] (
    [PersonId]                  SMALLINT         NOT NULL,
    [EffectiveDate]             DATETIME         CONSTRAINT [DF_EIH_EDT] DEFAULT (getdate()) NOT NULL,
    [Notes]                     VARBINARY (MAX)  NOT NULL,
    [JoinGUID]                  UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         CONSTRAINT [DF_EIH_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         CONSTRAINT [DF_EIH_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    CONSTRAINT [DF_EIH_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT              CONSTRAINT [DF_EIH_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         CONSTRAINT [DF_EIH_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKEmployeeInfoHistory] PRIMARY KEY CLUSTERED ([PersonId] ASC, [EffectiveDate] ASC),
    CONSTRAINT [EmployeeInfoHistoryPersonId] FOREIGN KEY ([PersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

