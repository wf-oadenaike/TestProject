CREATE TABLE [Compliance].[ConflictsRegisterActions_1] (
    [ConflictsRegisterActionId_1] INT            IDENTITY (1, 1) NOT NULL,
    [ConflictId]                  INT            NOT NULL,
    [ActionTypeId]                SMALLINT       NOT NULL,
    [ActionDate]                  DATETIME       NOT NULL,
    [ActionComment]               NVARCHAR (MAX) NULL,
    [CreatedByPersonId]           SMALLINT       NOT NULL,
    [CreationDate]                DATETIME       CONSTRAINT [DF_CRA_CDT_1] DEFAULT (getdate()) NOT NULL,
    [JIRAIssueKey]                VARCHAR (255)  NULL,
    [IsActive]                    BIT            DEFAULT ((1)) NOT NULL,
    [CADIS_SYSTEM_INSERTED]       DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]        DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]      NVARCHAR (50)  DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKConflictsRegisterActions_1] PRIMARY KEY CLUSTERED ([ConflictsRegisterActionId_1] ASC) WITH (FILLFACTOR = 80)
);

