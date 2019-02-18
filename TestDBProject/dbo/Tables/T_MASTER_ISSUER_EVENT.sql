CREATE TABLE [dbo].[T_MASTER_ISSUER_EVENT] (
    [Event_ID]               INT           IDENTITY (900000000, 1) NOT NULL,
    [EDM_Issuer_ID]          INT           NULL,
    [Recommendation]         VARCHAR (250) NULL,
    [EventType]              VARCHAR (250) NULL,
    [EventDate]              DATETIME      NULL,
    [EventSummary]           VARCHAR (MAX) NULL,
    [BoxFileID]              VARCHAR (250) NULL,
    [SubmittedByPersonID]    SMALLINT      NULL,
    [RAG]                    VARCHAR (10)  NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PK_T_MASTER_ISS_EVENT] PRIMARY KEY CLUSTERED ([Event_ID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_Person_ISS_EVENT] FOREIGN KEY ([SubmittedByPersonID]) REFERENCES [Core].[Persons] ([PersonId])
);

