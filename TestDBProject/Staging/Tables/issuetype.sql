CREATE TABLE [Staging].[issuetype] (
    [ID]          NVARCHAR (60)  NOT NULL,
    [SEQUENCE]    NUMERIC (18)   NULL,
    [pname]       NVARCHAR (60)  NULL,
    [pstyle]      NVARCHAR (60)  NULL,
    [DESCRIPTION] NTEXT          NULL,
    [ICONURL]     NVARCHAR (255) NULL,
    [AVATAR]      NUMERIC (18)   NULL,
    CONSTRAINT [PK_issuetype] PRIMARY KEY CLUSTERED ([ID] ASC)
);

