CREATE TABLE [dbo].[NewOrgStructureCircles] (
    [CircleId]               SMALLINT       IDENTITY (1, 1) NOT NULL,
    [Name]                   NVARCHAR (100) NULL,
    [Purpose]                NVARCHAR (MAX) NULL,
    [ParentCircleId]         SMALLINT       NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  DEFAULT ('UNKNOWN') NULL,
    [Label]                  NVARCHAR (100) NULL,
    [IsActive]               BIT            DEFAULT ((1)) NOT NULL,
    [CircleLead]             SMALLINT       NULL,
    [Facilitator]            SMALLINT       NULL,
    [HasCircleLead]          BIT            DEFAULT ((1)) NOT NULL,
    [HasFacilitator]         BIT            DEFAULT ((0)) NOT NULL,
    [ProjectKey]             NVARCHAR (20)  NULL,
    PRIMARY KEY CLUSTERED ([CircleId] ASC) WITH (FILLFACTOR = 80)
);

