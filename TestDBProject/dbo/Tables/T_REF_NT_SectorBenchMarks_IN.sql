CREATE TABLE [dbo].[T_REF_NT_SectorBenchMarks_IN] (
    [Sector]                 VARCHAR (500)   NULL,
    [BenchMarkWeight]        DECIMAL (18, 2) NULL,
    [EndWeight]              DECIMAL (18, 2) NULL,
    [AS_AT_DATE]             DATETIME        NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        CONSTRAINT [DF_T_REF_NT_SectorBenchMarks_IN_CADIS_SYSTEM_UPDATED] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        CONSTRAINT [DF_T_REF_NT_SectorBenchMarks_IN_CADIS_SYSTEM_INSERTED] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] VARCHAR (500)   CONSTRAINT [DF_T_REF_NT_SectorBenchMarks_IN_CADIS_SYSTEM_CHANGEDBY] DEFAULT ('UNKNOWN') NULL,
    [Fund_Short_Name]        VARCHAR (12)    NULL
);

