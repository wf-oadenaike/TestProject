CREATE TABLE [Sales].[ClientTakeOnTasks] (
    [ClientTakeOnTaskId]                    INT            IDENTITY (1, 1) NOT NULL,
    [Stage]                                 VARCHAR (50)   NOT NULL,
    [SummaryDetails]                        VARCHAR (MAX)  NOT NULL,
    [ReporterRole]                          VARCHAR (50)   NOT NULL,
    [AssigneeRole]                          VARCHAR (50)   NOT NULL,
    [Description]                           VARCHAR (MAX)  NULL,
    [DueDate]                               DATETIME       NULL,
    [IsActive]                              BIT            NULL,
    [JiraEpicKey]                           VARCHAR (2000) NULL,
    [Labels]                                VARCHAR (2000) NULL,
    [StoryPoints]                           INT            NULL,
    [IssueType]                             VARCHAR (50)   NULL,
    [ClientTakeOnTasksCreationDatetime]     DATETIME       CONSTRAINT [DF_CTOT_CTOTCDT] DEFAULT (getdate()) NOT NULL,
    [ClientTakeOnTasksLastModifiedDatetime] DATETIME       CONSTRAINT [DF_CTOT_CTOTLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                 DATETIME       CONSTRAINT [DF_CTOT_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                  DATETIME       CONSTRAINT [DF_CTOT_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                NVARCHAR (50)  CONSTRAINT [DF_CTOT_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                 INT            CONSTRAINT [DF_CTOT_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                ROWVERSION     NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]             DATETIME       CONSTRAINT [DF_CTOT_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKClientTakeOnTasks] PRIMARY KEY CLUSTERED ([ClientTakeOnTaskId] ASC)
);

