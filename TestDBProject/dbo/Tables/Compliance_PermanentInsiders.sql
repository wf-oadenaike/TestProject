CREATE TABLE [dbo].[Compliance_PermanentInsiders] (
    [PermanentInsiderID]     INT           IDENTITY (1, 1) NOT NULL,
    [PersonID]               SMALLINT      NOT NULL,
    [AdditionDateTime]       DATETIME      NULL,
    [CeasedDateTime]         DATETIME      NULL,
    [ActiveFlag]             BIT           DEFAULT ((1)) NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PILCompliance_PermanentInsiderList] PRIMARY KEY CLUSTERED ([PermanentInsiderID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [PILPersonID] FOREIGN KEY ([PersonID]) REFERENCES [Core].[Persons] ([PersonId])
);

