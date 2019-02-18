CREATE TABLE [dbo].[T_ExpostViolation_Violation_Bucket_IN] (
    [CADIS_BATCH_ID]         INT            NOT NULL,
    [CADIS_MSG_ID]           INT            CONSTRAINT [DF__T_ExpostV__CADIS__0E1EB065] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]        INT            NOT NULL,
    [CADIS_ROW_ID]           INT            NOT NULL,
    [Bucket_CADIS_ROW_ID]    INT            NULL,
    [Bucket_BucketBookVal]   NVARCHAR (100) NULL,
    [Bucket_BucketMktVal]    NVARCHAR (100) NULL,
    [Bucket_BucketName]      NVARCHAR (100) NULL,
    [Bucket_BucketParVal]    NVARCHAR (100) NULL,
    [Bucket_BucketTestVal]   NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       CONSTRAINT [DF__T_ExpostV__CADIS__0F12D49E] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       CONSTRAINT [DF__T_ExpostV__CADIS__1006F8D7] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  CONSTRAINT [DF__T_ExpostV__CADIS__10FB1D10] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT            CONSTRAINT [DF__T_ExpostV__CADIS__11EF4149] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_ExpostViolation_Violation_Bucket_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

