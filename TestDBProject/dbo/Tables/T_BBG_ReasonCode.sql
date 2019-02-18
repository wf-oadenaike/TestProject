CREATE TABLE [dbo].[T_BBG_ReasonCode] (
    [Code]        INT          NOT NULL,
    [Description] VARCHAR (4)  NULL,
    [Narrative]   VARCHAR (50) NULL,
    CONSTRAINT [PK_T_BBG_ReasonCode] PRIMARY KEY CLUSTERED ([Code] ASC) WITH (FILLFACTOR = 90)
);

