CREATE TABLE [TCA].[TCAOut] (
    [ID]                        INT             IDENTITY (1, 1) NOT NULL,
    [ROOT_I_TSORDNUM]           INT             NOT NULL,
    [LVL]                       INT             NOT NULL,
    [I_TSORDNUM]                INT             NOT NULL,
    [I_TSORDNUMDESC]            VARCHAR (200)   NULL,
    [C_ACCOUNT]                 VARCHAR (100)   NOT NULL,
    [C_BROKER]                  VARCHAR (100)   NOT NULL,
    [C_SIDE]                    VARCHAR (5)     NOT NULL,
    [ORDER_QUANTITY]            DECIMAL (18, 6) NOT NULL,
    [ALLOCATED_QUANTITY]        DECIMAL (18, 6) NOT NULL,
    [REMAINDER]                 DECIMAL (18, 6) NOT NULL,
    [RATIO]                     DECIMAL (18, 6) NULL,
    [TOP_LEVEL_DERIVED]         BIT             NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        CONSTRAINT [DF_TCA_TCAOut_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        CONSTRAINT [DF_TCA_TCAOut_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   CONSTRAINT [DF_TCA_TCAOut_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             CONSTRAINT [DF_TCA_TCAOut_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION      NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        CONSTRAINT [DF_TCA_TCAOut_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKTCA_TCAOut] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);

