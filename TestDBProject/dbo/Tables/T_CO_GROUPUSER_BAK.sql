CREATE TABLE [dbo].[T_CO_GROUPUSER_BAK] (
    [ID]         INT            IDENTITY (1, 1) NOT NULL,
    [GROUPID]    INT            NOT NULL,
    [NAME]       NVARCHAR (200) NULL,
    [USERTYPE]   TINYINT        NOT NULL,
    [PERMISSION] SMALLINT       NOT NULL
);

