CREATE TABLE [dbo].[T_Warehouse_Users] (
    [UserID]                 VARCHAR (20)  NULL,
    [First_Name]             VARCHAR (30)  NULL,
    [Last_Name]              VARCHAR (40)  NULL,
    [Is_Approved]            BIT           NULL,
    [Is_Locked_Out]          BIT           NULL,
    [Last_Login]             DATETIME      NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL
);

