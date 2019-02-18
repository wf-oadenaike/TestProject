CREATE TABLE [Sales].[ClientTakeOnCheckList] (
    [ClientTakeOnCheckListId]                   SMALLINT         IDENTITY (1, 1) NOT NULL,
    [CheckListTemplateId]                       SMALLINT         NOT NULL,
    [ClientTakeOnId]                            INT              NOT NULL,
    [CheckItemTrueFalse]                        BIT              NULL,
    [RecordedByPersonId]                        SMALLINT         CONSTRAINT [DF_CTOCL_CTOCLRP] DEFAULT ((-1)) NOT NULL,
    [DocumentationFolderLink]                   VARCHAR (2000)   NULL,
    [JoinGUID]                                  UNIQUEIDENTIFIER NOT NULL,
    [ClientTakeOnCheckListCreationDatetime]     DATETIME         CONSTRAINT [DF_CTOCL_CTOCLCDT] DEFAULT (getdate()) NOT NULL,
    [ClientTakeOnCheckListLastModifiedDatetime] DATETIME         CONSTRAINT [DF_CTOCL_CTOCLLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                     DATETIME         CONSTRAINT [DF_CTOCL_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                      DATETIME         CONSTRAINT [DF_CTOCL_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                    NVARCHAR (50)    CONSTRAINT [DF_CTOCL_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                     INT              CONSTRAINT [DF_CTOCL_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                    ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]                 DATETIME         CONSTRAINT [DF_CTOCL_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKClientTakeOnCheckList] PRIMARY KEY CLUSTERED ([ClientTakeOnCheckListId] ASC),
    CONSTRAINT [ClientTakeOnCheckListCheckListTemplateId] FOREIGN KEY ([CheckListTemplateId]) REFERENCES [Sales].[ClientTakeOnCheckListTemplate] ([CheckListTemplateId]),
    CONSTRAINT [ClientTakeOnCheckListClientTakeOnId] FOREIGN KEY ([ClientTakeOnId]) REFERENCES [Sales].[ClientTakeOnRegister] ([ClientTakeOnId]),
    CONSTRAINT [ClientTakeOnCheckListRecordedByPersonId] FOREIGN KEY ([RecordedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

