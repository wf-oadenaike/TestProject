CREATE TABLE [TCA].[TCANarrativeEvents] (
    [NarrativeEventId]          INT              IDENTITY (1, 1) NOT NULL,
    [OrderId]                   INT              NOT NULL,
    [Narrative]                 NVARCHAR (MAX)   NULL,
    [EventType]                 VARCHAR (20)     NOT NULL,
    [EventDate]                 DATETIME         CONSTRAINT [DF_TNE_SLECD] DEFAULT (getdate()) NOT NULL,
    [PostedBy]                  VARCHAR (128)    NULL,
    [JoinGUID]                  UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         CONSTRAINT [DF_TNE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         CONSTRAINT [DF_TNE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    CONSTRAINT [DF_TNE_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT              CONSTRAINT [DF_TNE_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         CONSTRAINT [DF_TNE_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKNarrativeEvents] PRIMARY KEY CLUSTERED ([NarrativeEventId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDX_TCA_Narrative]
    ON [TCA].[TCANarrativeEvents]([OrderId] ASC)
    INCLUDE([Narrative], [EventDate]) WITH (FILLFACTOR = 80);

