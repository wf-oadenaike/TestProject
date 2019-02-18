CREATE TABLE [dbo].[T_EndOfDayViolation_Violation_Bucket_Security_IN] (
    [CADIS_BATCH_ID]         INT            NOT NULL,
    [CADIS_MSG_ID]           INT            CONSTRAINT [DF__T_EndOfDa__CADIS__07A6BD00] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]        INT            NOT NULL,
    [CADIS_ROW_ID]           INT            NOT NULL,
    [Security_CADIS_ROW_ID]  INT            NULL,
    [Security_SecBookVal]    NVARCHAR (100) NULL,
    [Security_SecBuySell]    NVARCHAR (100) NULL,
    [Security_SecCurncy]     NVARCHAR (100) NULL,
    [Security_SecDesc]       NVARCHAR (100) NULL,
    [Security_SecIdent]      NVARCHAR (100) NULL,
    [Security_SecMktVal]     NVARCHAR (100) NULL,
    [Security_SecParVal]     NVARCHAR (100) NULL,
    [Security_SecPosition]   NVARCHAR (100) NULL,
    [Security_SecPrice]      NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       CONSTRAINT [DF__T_EndOfDa__CADIS__089AE139] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       CONSTRAINT [DF__T_EndOfDa__CADIS__098F0572] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  CONSTRAINT [DF__T_EndOfDa__CADIS__0A8329AB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT            CONSTRAINT [DF__T_EndOfDa__CADIS__0B774DE4] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_EndOfDayViolation_Violation_Bucket_Security_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

