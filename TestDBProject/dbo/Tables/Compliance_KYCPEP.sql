CREATE TABLE [dbo].[Compliance_KYCPEP] (
    [PEPID]                  INT              IDENTITY (1, 1) NOT NULL,
    [ChecklistID]            INT              NOT NULL,
    [FullName]               VARCHAR (50)     NOT NULL,
    [PersonDetails]          VARCHAR (2000)   NULL,
    [SubmittedByPersonID]    SMALLINT         NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [PoliticalPositionID]    INT              NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL,
    [IsActive]               BIT              DEFAULT ('1') NOT NULL,
    CONSTRAINT [PKCompliance_KYCPEP] PRIMARY KEY CLUSTERED ([PEPID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [CSubmittedByPersonID] FOREIGN KEY ([SubmittedByPersonID]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [KYCCChecklistID] FOREIGN KEY ([ChecklistID]) REFERENCES [dbo].[Compliance_KYCChecklist] ([ChecklistID]),
    CONSTRAINT [KYCCPoliticalPositionID] FOREIGN KEY ([PoliticalPositionID]) REFERENCES [dbo].[Compliance_KYCPoliticalPosition] ([PoliticalPositionID])
);

