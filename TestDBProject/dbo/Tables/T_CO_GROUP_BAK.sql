CREATE TABLE [dbo].[T_CO_GROUP_BAK] (
    [GROUPID]                INT            IDENTITY (1, 1) NOT NULL,
    [NAME]                   NVARCHAR (100) NOT NULL,
    [ORDER]                  INT            NULL,
    [PARENTGROUP]            INT            NULL,
    [SYSTEM]                 BIT            NOT NULL,
    [CADIS_SYSTEM_TIMESTAMP] ROWVERSION     NOT NULL
);

