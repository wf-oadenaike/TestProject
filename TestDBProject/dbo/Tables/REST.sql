CREATE TABLE [dbo].[REST] (
    [ROW_ID]   INT              IDENTITY (1, 1) NOT NULL,
    [TEXT]     VARCHAR (200)    NULL,
    [NUMBER]   INT              NULL,
    [DATETIME] DATETIME         NULL,
    [BIT]      BIT              NULL,
    [DECIMAL]  DECIMAL (20, 10) NULL,
    PRIMARY KEY CLUSTERED ([ROW_ID] ASC) WITH (FILLFACTOR = 80)
);

