CREATE TABLE [dbo].[Compliance_KYCUBOControllers] (
    [UBOControllersID]       INT              IDENTITY (1, 1) NOT NULL,
    [SubmittedByPersonID]    SMALLINT         NOT NULL,
    [ChecklistID]            INT              NOT NULL,
    [Name]                   VARCHAR (50)     NOT NULL,
    [PersonType]             VARCHAR (2000)   NULL,
    [Details]                VARCHAR (2000)   NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL,
    [Controller]             BIT              NOT NULL,
    [IsActive]               BIT              DEFAULT ('1') NOT NULL,
    CONSTRAINT [PKCompliance_KYCUBOControllers] PRIMARY KEY CLUSTERED ([UBOControllersID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [KYChecklistID] FOREIGN KEY ([ChecklistID]) REFERENCES [dbo].[Compliance_KYCChecklist] ([ChecklistID])
);

