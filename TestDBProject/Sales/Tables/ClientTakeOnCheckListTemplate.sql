CREATE TABLE [Sales].[ClientTakeOnCheckListTemplate] (
    [CheckListTemplateId]               SMALLINT      IDENTITY (1, 1) NOT NULL,
    [CheckListItemName]                 VARCHAR (128) NOT NULL,
    [EventType]                         VARCHAR (128) NOT NULL,
    [CheckListTemplateCreationDatetime] DATETIME      CONSTRAINT [DF_CTOCLT_CTOCLTCDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKClientTakeOnCheckListTemplate] PRIMARY KEY CLUSTERED ([CheckListTemplateId] ASC)
);

