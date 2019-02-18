CREATE TABLE [dbo].[T_SLA_PARAM] (
    [PLATFORM]                        VARCHAR (50)  NOT NULL,
    [SOURCE]                          VARCHAR (50)  NOT NULL,
    [ENTITY]                          VARCHAR (50)  NOT NULL,
    [SUB_ENTITY]                      VARCHAR (50)  NOT NULL,
    [DESCRIPTION]                     VARCHAR (200) NOT NULL,
    [DIRECTION]                       VARCHAR (200) NOT NULL,
    [RECORDS]                         INT           NULL,
    [TOLERANCE_PRECENT]               INT           NULL,
    [SOLUTION]                        VARCHAR (200) NULL,
    [TABLE_NAME]                      VARCHAR (200) NULL,
    [EXPECTED_TIME_GMT]               TIME (7)      NULL,
    [EXPECTED_TIME_TOLERANCE_MINUTES] INT           NULL,
    [EMAIL_RECIPIENT]                 VARCHAR (200) NULL,
    [OWNER]                           SMALLINT      NULL,
    [SEND_SLACK]                      BIT           NULL,
    [SEND_EMAIL]                      BIT           NULL,
    [IS_ACTIVE]                       BIT           NULL,
    [CADIS_SYSTEM_INSERTED]           DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]            DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]          NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([PLATFORM] ASC, [SOURCE] ASC, [ENTITY] ASC, [SUB_ENTITY] ASC) WITH (FILLFACTOR = 80)
);

