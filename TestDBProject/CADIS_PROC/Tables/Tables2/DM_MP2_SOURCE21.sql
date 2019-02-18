﻿CREATE TABLE [CADIS_PROC].[DM_MP2_SOURCE21] (
    [CCY_CODE]       VARCHAR (20)   NOT NULL,
    [CADISID]        INT            NOT NULL,
    [CADISPRIORITY]  TINYINT        CONSTRAINT [DF_DM_MP2_SOURCE21_PRIORITY] DEFAULT ((2)) NOT NULL,
    [CADISINSERTED]  DATETIME       NOT NULL,
    [CADISUPDATED]   DATETIME       NOT NULL,
    [CADISCHANGEDBY] NVARCHAR (100) NOT NULL,
    [CADISROWID]     INT            IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [CK_DM_MP2_SOURCE21_PRIORITY] CHECK ([CADISPRIORITY]=(1) OR [CADISPRIORITY]=(2) OR [CADISPRIORITY]=(3))
);


GO
CREATE CLUSTERED INDEX [IDXDM_MP2_SOURCE21_PKRID2]
    ON [CADIS_PROC].[DM_MP2_SOURCE21]([CCY_CODE] ASC, [CADISROWID] ASC, [CADISID] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDXDM_MP2_SOURCE21]
    ON [CADIS_PROC].[DM_MP2_SOURCE21]([CCY_CODE] ASC);


GO
CREATE NONCLUSTERED INDEX [IDXDM_MP2_SOURCE21_CRID]
    ON [CADIS_PROC].[DM_MP2_SOURCE21]([CADISROWID] ASC);


GO
CREATE NONCLUSTERED INDEX [IDXDM_MP2_SOURCE21_CID]
    ON [CADIS_PROC].[DM_MP2_SOURCE21]([CADISID] ASC);


GO
CREATE NONCLUSTERED INDEX [IDXDM_MP2_SOURCE21_PKID]
    ON [CADIS_PROC].[DM_MP2_SOURCE21]([CCY_CODE] ASC);


GO
CREATE NONCLUSTERED INDEX [IDXDM_MP2_SOURCE21_PKRID]
    ON [CADIS_PROC].[DM_MP2_SOURCE21]([CCY_CODE] ASC, [CADISROWID] ASC);


GO
	
		CREATE TRIGGER [CADIS_PROC].[TRGDM_MP2_SOURCE21_REVISION] ON "CADIS_PROC"."DM_MP2_SOURCE21" 
		FOR insert/*sp_password*/,update/*sp_password*/
		AS
			insert/*sp_password*/
			INTO	"CADIS_PROC"."DM_MP2_SOURCE21_REVISION"
				(
					"CCY_CODE"	,
					[REVISION] 	,
					[REVISIONEFFECTIVE],
					[CADISID],
					[CADISROWID]
				)
				select/*sp_password*/	MP."CCY_CODE",
					ISNULL(RV.REVISION,0) + 1,
					MP.CADISUPDATED,
					MP.CADISID,
					MP.CADISROWID
				FROM	INSERTED AS MP
					LEFT OUTER JOIN DELETED AS SR
								ON SR."CCY_CODE" = MP."CCY_CODE"
					LEFT OUTER JOIN (	select/*sp_password*/	"CCY_CODE", MAX(REVISION) AS REVISION
								FROM	"CADIS_PROC"."DM_MP2_SOURCE21_REVISION" 
								GROUP BY "CCY_CODE"	) RV
						ON RV."CCY_CODE" = MP."CCY_CODE"
				WHERE	MP.CADISID <> ISNULL(SR.CADISID,0)
		