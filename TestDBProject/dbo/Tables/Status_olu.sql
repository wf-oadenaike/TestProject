CREATE TABLE [dbo].[Status_olu] (
    [StatusId]               INT           IDENTITY (1, 1) NOT NULL,
    [StatusCode]             VARCHAR (300) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) NULL
);

