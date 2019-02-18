CREATE TABLE [Access.WebDev].[AllocationVolumeChanges] (
    [OrderDate]              VARCHAR (8)     NULL,
    [Year]                   VARCHAR (4)     NULL,
    [Month]                  VARCHAR (2)     NULL,
    [Activated_Order]        INT             NULL,
    [Activated_Account]      VARCHAR (20)    NULL,
    [Activated_Order_Amount] INT             NULL,
    [Activated_Order_Pct]    DECIMAL (10, 6) NULL,
    [Allocated_Order]        INT             NULL,
    [Allocated_Account]      VARCHAR (20)    NULL,
    [Allocated_Order_Amount] INT             NULL,
    [Allocated_Order_Pct]    DECIMAL (10, 6) NULL,
    [Stock]                  VARCHAR (100)   NULL,
    [Is_Missing]             BIT             CONSTRAINT [DF_AllocationVolumeChanges_Is_Missing] DEFAULT ((0)) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        CONSTRAINT [DF_AllocationVolumeChanges_CADIS_SYSTEM_INSERTED] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        CONSTRAINT [DF_AllocationVolumeChanges_CADIS_SYSTEM_UPDATED] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   CONSTRAINT [DF_AllocationVolumeChanges_CADIS_SYSTEM_CHANGEDBY] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT             CONSTRAINT [DF_AllocationVolumeChanges_CADIS_SYSTEM_PRIORITY] DEFAULT ((1)) NULL
);

