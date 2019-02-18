﻿CREATE TABLE [CADIS_PROC].[DM_MP2_RESULT] (
    [ID]          INT            IDENTITY (1, 1) NOT NULL,
    [SOURCEID]    INT            NOT NULL,
    [SOURCEROWID] INT            NOT NULL,
    [CADISID]     INT            NOT NULL,
    [PRIORITY]    TINYINT        DEFAULT ((2)) NOT NULL,
    [RULEID]      INT            NOT NULL,
    [PROVISIONAL] TINYINT        DEFAULT ((0)) NOT NULL,
    [COMMENT]     NVARCHAR (250) NULL,
    [INSERTED]    DATETIME       NOT NULL,
    [UPDATED]     DATETIME       NOT NULL,
    [CHANGEDBY]   NVARCHAR (100) NOT NULL,
    CONSTRAINT [PK_DM_MP2_RESULT] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [CK_DM_MP2_RESULT_PROV] CHECK ([PROVISIONAL]=(1) OR [PROVISIONAL]=(0)),
    CONSTRAINT [FK_DM_RULE_DM_MP2_RESULT] FOREIGN KEY ([RULEID]) REFERENCES [CADIS_SYS].[DM_RULE] ([RULEID]),
    CONSTRAINT [FK_DM_SOURCE_DM_MP2_RESULT] FOREIGN KEY ([SOURCEID]) REFERENCES [CADIS_SYS].[DM_SOURCE] ([SOURCEID])
);


GO
CREATE NONCLUSTERED INDEX [IDXDM_MP2_RESULT_IDS]
    ON [CADIS_PROC].[DM_MP2_RESULT]([SOURCEID] ASC, [PROVISIONAL] ASC, [SOURCEROWID] ASC);


GO

	CREATE TRIGGER [CADIS_PROC].[TRGDM_MP2_RESULT_AUDIT] ON [CADIS_PROC].[DM_MP2_RESULT] 
	FOR insert/*sp_password*/,update/*sp_password*/
	AS
	
	insert/*sp_password*/
	INTO	[CADIS_PROC].[DM_MP2_RESULT_AUDIT] 
		(
			[AUDITDATE] 	,
			[SOURCEID] 	,
			[SOURCEROWID] 	,
			[RESULTID] 	,
			[CADISID] 	,
			[PRIORITY] 	,
			[RULEID] 	,
			[PROVISIONAL] 	,
			[COMMENT] 	,
			[INSERTED] 	,
			[UPDATED] 	,
			[CHANGEDBY]
		)
		select/*sp_password*/	GETDATE()	,
			[SOURCEID] 	,
			[SOURCEROWID] 	,
			[ID] 		,
			[CADISID] 	,
			[PRIORITY] 	,
			[RULEID] 	,
			[PROVISIONAL] 	,
			[COMMENT] 	,
			[INSERTED] 	,
			[UPDATED] 	,
			[CHANGEDBY]
		FROM	INSERTED
	