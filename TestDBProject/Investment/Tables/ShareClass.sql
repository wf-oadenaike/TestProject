CREATE TABLE [Investment].[ShareClass] (
    [ShareClassId]              INT           IDENTITY (1, 1) NOT NULL,
    [MandateId]                 INT           NOT NULL,
    [ShareClass]                VARCHAR (10)  NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF_SC_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF_SC_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) CONSTRAINT [DF_SC_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           CONSTRAINT [DF_SC_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      CONSTRAINT [DF_SC_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKShareClass] PRIMARY KEY CLUSTERED ([ShareClassId] ASC),
    CONSTRAINT [ShareClassMandateId] FOREIGN KEY ([MandateId]) REFERENCES [Investment].[Mandates] ([MandateId])
);

