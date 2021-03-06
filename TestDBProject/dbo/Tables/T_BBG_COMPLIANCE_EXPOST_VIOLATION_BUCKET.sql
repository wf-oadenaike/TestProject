﻿CREATE TABLE [dbo].[T_BBG_COMPLIANCE_EXPOST_VIOLATION_BUCKET] (
    [CADIS_PARENT_ID]        VARCHAR (50)  NULL,
    [BUCKET_BUCKETBOOKVAL]   VARCHAR (50)  NULL,
    [BUCKET_BUCKETMKTVAL]    VARCHAR (50)  NULL,
    [BUCKET_BUCKETNAME]      VARCHAR (50)  NULL,
    [BUCKET_BUCKETPARVAL]    VARCHAR (50)  NULL,
    [BUCKET_BUCKETTESTVAL]   VARCHAR (50)  NULL,
    [SECURITY_SECBOOKVAL]    VARCHAR (50)  NULL,
    [SECURITY_SECBUYSELL]    VARCHAR (50)  NULL,
    [SECURITY_SECCURNCY]     VARCHAR (50)  NULL,
    [SECURITY_SECDESC]       VARCHAR (50)  NULL,
    [SECURITY_SECIDENT]      VARCHAR (50)  NULL,
    [SECURITY_SECMKTVAL]     VARCHAR (50)  NULL,
    [SECURITY_SECPARVAL]     VARCHAR (50)  NULL,
    [SECURITY_SECPOSITION]   VARCHAR (50)  NULL,
    [SECURITY_SECPRICE]      VARCHAR (50)  NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      CONSTRAINT [DF__T_BBG_COM__CADIS__2CA33785] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      CONSTRAINT [DF__T_BBG_COM__CADIS__2D975BBE] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) CONSTRAINT [DF__T_BBG_COM__CADIS__2E8B7FF7] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT           CONSTRAINT [DF__T_BBG_COM__CADIS__2F7FA430] DEFAULT ((1)) NULL
);

