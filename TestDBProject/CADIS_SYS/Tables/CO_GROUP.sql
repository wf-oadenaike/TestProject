CREATE TABLE [CADIS_SYS].[CO_GROUP] (
    [GROUPID]                INT            IDENTITY (1, 1) NOT NULL,
    [NAME]                   NVARCHAR (100) NOT NULL,
    [ORDER]                  INT            NULL,
    [PARENTGROUP]            INT            NULL,
    [SYSTEM]                 BIT            NOT NULL,
    [CADIS_SYSTEM_TIMESTAMP] ROWVERSION     NOT NULL,
    CONSTRAINT [PK_CO_GROUP] PRIMARY KEY CLUSTERED ([GROUPID] ASC)
);

