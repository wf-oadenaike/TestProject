CREATE TABLE [Sales].[ClientTakeOnMandates] (
    [MandateId]                               INT              IDENTITY (1, 1) NOT NULL,
    [ClientTakeOnId]                          INT              NOT NULL,
    [MandateName]                             VARCHAR (128)    NOT NULL,
    [MandateDescription]                      VARCHAR (128)    NULL,
    [IsWoodfordMandate]                       BIT              NULL,
    [RecordedByPersonId]                      SMALLINT         CONSTRAINT [DF_CTOM_CTOMRP] DEFAULT ((-1)) NOT NULL,
    [DocumentationFolderLink]                 VARCHAR (2000)   NULL,
    [JoinGUID]                                UNIQUEIDENTIFIER NOT NULL,
    [ClientTakeOnMandateCreationDatetime]     DATETIME         CONSTRAINT [DF_CTOM_CTOMCDT] DEFAULT (getdate()) NOT NULL,
    [ClientTakeOnMandateLastModifiedDatetime] DATETIME         CONSTRAINT [DF_CTOM_CTOMLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                   DATETIME         CONSTRAINT [DF_CTOM_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                    DATETIME         CONSTRAINT [DF_CTOM_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                  NVARCHAR (50)    CONSTRAINT [DF_CTOM_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                   INT              CONSTRAINT [DF_CTOM_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                  ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]               DATETIME         CONSTRAINT [DF_CTOM_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKClientTakeOnMandates] PRIMARY KEY CLUSTERED ([MandateId] ASC),
    CONSTRAINT [ClientTakeOnMandateClientTakeOnId] FOREIGN KEY ([ClientTakeOnId]) REFERENCES [Sales].[ClientTakeOnRegister] ([ClientTakeOnId]),
    CONSTRAINT [ClientTakeOnMandateRecordedByPersonId] FOREIGN KEY ([RecordedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

