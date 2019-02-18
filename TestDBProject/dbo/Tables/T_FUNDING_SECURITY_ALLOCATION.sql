CREATE TABLE [dbo].[T_FUNDING_SECURITY_ALLOCATION] (
    [Fund_Security_AllocationID] INT              NOT NULL,
    [AllocationID]               INT              NULL,
    [EDM_SEC_ID]                 INT              NULL,
    [AllocationAmount]           DECIMAL (38, 12) NULL,
    [CADIS_SYSTEM_INSERTED]      DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]       DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]     NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PK_T_FUNDING_SECURITY_ALLOCATION] PRIMARY KEY CLUSTERED ([Fund_Security_AllocationID] ASC) WITH (FILLFACTOR = 80)
);

