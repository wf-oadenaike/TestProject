CREATE TABLE [Investment].[T_UnquotedRevaluations] (
    [ID]                     INT             IDENTITY (1, 1) NOT NULL,
    [SecurityID]             INT             NULL,
    [ExpectedEnactmentDate]  DATETIME        NULL,
    [ActualEnactmentDate]    DATETIME        NULL,
    [StatusID]               INT             NULL,
    [FMHighEstimate]         DECIMAL (18, 2) NULL,
    [FMLowEstimate]          DECIMAL (18, 2) NULL,
    [AdviserHighEstimate]    DECIMAL (18, 2) NULL,
    [AdviserLowEstimate]     DECIMAL (18, 2) NULL,
    [ACDValuation]           DECIMAL (18, 2) NULL,
    [JiraIssueKey]           VARCHAR (2)     NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PK_UnquotedRevaluationID] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);

