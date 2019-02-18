CREATE TABLE [Investment].[T_REF_ICBSubsectors] (
    [ID]          SMALLINT       NOT NULL,
    [ICBID]       VARCHAR (4)    NOT NULL,
    [Name]        VARCHAR (100)  NOT NULL,
    [SectorID]    SMALLINT       NULL,
    [Active]      BIT            DEFAULT ('0') NULL,
    [Description] VARCHAR (1000) NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_Investment.T_REF_ICB.SectorID] FOREIGN KEY ([SectorID]) REFERENCES [Investment].[T_REF_ICBSectors] ([ID])
);

