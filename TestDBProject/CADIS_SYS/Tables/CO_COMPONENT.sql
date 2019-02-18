CREATE TABLE [CADIS_SYS].[CO_COMPONENT] (
    [ID]                    INT            NOT NULL,
    [GROUPNAME]             NVARCHAR (50)  NOT NULL,
    [NAME]                  NVARCHAR (50)  NOT NULL,
    [DESCRIPTION]           NVARCHAR (100) NOT NULL,
    [TABLE]                 NVARCHAR (60)  NULL,
    [ENABLED]               TINYINT        DEFAULT ((1)) NOT NULL,
    [EXPIRYDURATIONMINUTES] INT            DEFAULT ((60)) NOT NULL,
    [MAXRETRYATTEMPTS]      INT            DEFAULT ((10)) NOT NULL,
    [RETRYINTERVALSECONDS]  INT            DEFAULT ((60)) NOT NULL,
    [GROUPORDER]            INT            DEFAULT ((0)) NOT NULL,
    [COMPONENTORDER]        INT            DEFAULT ((0)) NOT NULL,
    [MAXEDITABLE]           INT            DEFAULT ((0)) NOT NULL,
    [VERIFIABLE]            BIT            DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_CO_COMPONENT] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

