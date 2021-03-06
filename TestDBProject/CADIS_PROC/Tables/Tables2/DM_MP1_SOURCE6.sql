﻿CREATE TABLE [CADIS_PROC].[DM_MP1_SOURCE6] (
    [MASTER_BROKER_NUMBER] VARCHAR (40)   NOT NULL,
    [CADISID]              INT            NOT NULL,
    [CADISPRIORITY]        TINYINT        CONSTRAINT [DF_DM_MP1_SOURCE6_PRIORITY] DEFAULT ((2)) NOT NULL,
    [CADISINSERTED]        DATETIME       NOT NULL,
    [CADISUPDATED]         DATETIME       NOT NULL,
    [CADISCHANGEDBY]       NVARCHAR (100) NOT NULL,
    [CADISROWID]           INT            IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [CK_DM_MP1_SOURCE6_PRIORITY] CHECK ([CADISPRIORITY]=(1) OR [CADISPRIORITY]=(2) OR [CADISPRIORITY]=(3))
);


GO
CREATE CLUSTERED INDEX [IDXDM_MP1_SOURCE6_PKRID2]
    ON [CADIS_PROC].[DM_MP1_SOURCE6]([MASTER_BROKER_NUMBER] ASC, [CADISROWID] ASC, [CADISID] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDXDM_MP1_SOURCE6]
    ON [CADIS_PROC].[DM_MP1_SOURCE6]([MASTER_BROKER_NUMBER] ASC);


GO
CREATE NONCLUSTERED INDEX [IDXDM_MP1_SOURCE6_CRID]
    ON [CADIS_PROC].[DM_MP1_SOURCE6]([CADISROWID] ASC);


GO
CREATE NONCLUSTERED INDEX [IDXDM_MP1_SOURCE6_CID]
    ON [CADIS_PROC].[DM_MP1_SOURCE6]([CADISID] ASC);


GO
CREATE NONCLUSTERED INDEX [IDXDM_MP1_SOURCE6_PKID]
    ON [CADIS_PROC].[DM_MP1_SOURCE6]([MASTER_BROKER_NUMBER] ASC);


GO
CREATE NONCLUSTERED INDEX [IDXDM_MP1_SOURCE6_PKRID]
    ON [CADIS_PROC].[DM_MP1_SOURCE6]([MASTER_BROKER_NUMBER] ASC, [CADISROWID] ASC);


GO
	
		CREATE TRIGGER [CADIS_PROC].[TRGDM_MP1_SOURCE6_REVISION] ON "CADIS_PROC"."DM_MP1_SOURCE6" 
		FOR insert/*sp_password*/,update/*sp_password*/
		AS
			insert/*sp_password*/
			INTO	"CADIS_PROC"."DM_MP1_SOURCE6_REVISION"
				(
					"MASTER_BROKER_NUMBER"	,
					[REVISION] 	,
					[REVISIONEFFECTIVE],
					[CADISID],
					[CADISROWID]
				)
				select/*sp_password*/	MP."MASTER_BROKER_NUMBER",
					ISNULL(RV.REVISION,0) + 1,
					MP.CADISUPDATED,
					MP.CADISID,
					MP.CADISROWID
				FROM	INSERTED AS MP
					LEFT OUTER JOIN DELETED AS SR
								ON SR."MASTER_BROKER_NUMBER" = MP."MASTER_BROKER_NUMBER"
					LEFT OUTER JOIN (	select/*sp_password*/	"MASTER_BROKER_NUMBER", MAX(REVISION) AS REVISION
								FROM	"CADIS_PROC"."DM_MP1_SOURCE6_REVISION" 
								GROUP BY "MASTER_BROKER_NUMBER"	) RV
						ON RV."MASTER_BROKER_NUMBER" = MP."MASTER_BROKER_NUMBER"
				WHERE	MP.CADISID <> ISNULL(SR.CADISID,0)
		