CREATE TABLE [Investment].[T_ReferenceData] (
    [Topic]                  VARCHAR (255) NULL,
    [Subtopic]               VARCHAR (255) NULL,
    [FieldName]              VARCHAR (255) NULL,
    [ID]                     INT           IDENTITY (1, 1) NOT NULL,
    [FieldValue]             VARCHAR (255) NULL,
    [Order]                  INT           NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PK_InvestmentReferenceDataID] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);

