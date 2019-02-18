CREATE TABLE [Sales.BP].[WoodfordEvent] (
    [Id]             INT            IDENTITY (1, 1) NOT NULL,
    [EventDateTime]  DATETIME       NOT NULL,
    [SfActivityId]   CHAR (18)      NOT NULL,
    [SfAccountId]    CHAR (18)      NOT NULL,
    [SfOwnerId]      CHAR (18)      NOT NULL,
    [Location]       NVARCHAR (MAX) NULL,
    [Subject]        NVARCHAR (MAX) NULL,
    [HasNotes]       BIT            CONSTRAINT [c_we_HasNotes] DEFAULT ('0') NOT NULL,
    [RequiresAction] BIT            CONSTRAINT [c_we_RequiresAction] DEFAULT ('0') NOT NULL,
    [StartDateTime]  DATETIME       CONSTRAINT [c_we_StartDateTime] DEFAULT (getdate()) NOT NULL,
    [EndDateTime]    DATETIME       CONSTRAINT [c_we_EndDateTime] DEFAULT ('2099-12-31T00:00:00') NOT NULL,
    [IsActive]       BIT            CONSTRAINT [c_we_IsActiveDefault] DEFAULT ('1') NOT NULL,
    CONSTRAINT [pk_we_id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [uc_we_sadedt] UNIQUE NONCLUSTERED ([SfActivityId] ASC, [EndDateTime] ASC)
);

