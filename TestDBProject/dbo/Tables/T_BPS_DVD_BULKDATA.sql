CREATE TABLE [dbo].[T_BPS_DVD_BULKDATA] (
    [UniqueId]                  VARCHAR (30)    NOT NULL,
    [FieldMnemonic]             VARCHAR (50)    NOT NULL,
    [RowId]                     VARCHAR (50)    NOT NULL,
    [ColId]                     VARCHAR (50)    NOT NULL,
    [DataType]                  INT             NULL,
    [ValueText]                 VARCHAR (150)   NULL,
    [ValueNumeric]              DECIMAL (28, 6) NULL,
    [ValueDate]                 DATETIME        NULL,
    [Cadis_Id]                  INT             NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION      NOT NULL,
    PRIMARY KEY CLUSTERED ([UniqueId] ASC, [FieldMnemonic] ASC, [RowId] ASC, [ColId] ASC) WITH (FILLFACTOR = 90)
);

