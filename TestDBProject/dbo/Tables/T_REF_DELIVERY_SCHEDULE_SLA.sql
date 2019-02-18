CREATE TABLE [dbo].[T_REF_DELIVERY_SCHEDULE_SLA] (
    [DELIVERY_SCHEDULE_ID]   INT           IDENTITY (1, 1) NOT NULL,
    [DESCRIPTION]            VARCHAR (50)  NULL,
    [LIST_ORDER]             INT           NULL,
    [MONDAY]                 BIT           NULL,
    [TUESDAY]                BIT           NULL,
    [WEDNESDAY]              BIT           NULL,
    [THURSDAY]               BIT           NULL,
    [FRIDAY]                 BIT           NULL,
    [SATURDAY]               BIT           NULL,
    [SUNDAY]                 BIT           NULL,
    [ACTIVE]                 BIT           NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([DELIVERY_SCHEDULE_ID] ASC) WITH (FILLFACTOR = 80)
);

