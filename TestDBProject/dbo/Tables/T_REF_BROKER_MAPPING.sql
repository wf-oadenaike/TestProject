﻿CREATE TABLE [dbo].[T_REF_BROKER_MAPPING] (
    [ID]                     INT           IDENTITY (1, 1) NOT NULL,
    [Broker_ID]              VARCHAR (50)  NOT NULL,
    [NT_Broker_Name]         VARCHAR (200) NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      CONSTRAINT [DF_staging_Matrix_Contact_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      CONSTRAINT [DF_staging_Matrix_Contact_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] VARCHAR (50)  CONSTRAINT [DF_staging_Matrix_Contact_CSCB] DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PK__T_REF_BROKER_MAPPING] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_T_REF_BROKER_MAPPING_Broker_ID_NT_Broker_Name]
    ON [dbo].[T_REF_BROKER_MAPPING]([Broker_ID] ASC, [NT_Broker_Name] ASC) WITH (FILLFACTOR = 80);

