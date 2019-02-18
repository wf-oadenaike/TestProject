﻿CREATE TABLE [CADIS_PROC].[DM_MP2_SOURCE20] (
    [UNIQUE_IDENTIFIER] VARCHAR (30)   NOT NULL,
    [CADISID]           INT            NOT NULL,
    [CADISPRIORITY]     TINYINT        CONSTRAINT [DF_DM_MP2_SOURCE20_PRIORITY] DEFAULT ((2)) NOT NULL,
    [CADISINSERTED]     DATETIME       NOT NULL,
    [CADISUPDATED]      DATETIME       NOT NULL,
    [CADISCHANGEDBY]    NVARCHAR (100) NOT NULL,
    [CADISROWID]        INT            IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [CK_DM_MP2_SOURCE20_PRIORITY] CHECK ([CADISPRIORITY]=(1) OR [CADISPRIORITY]=(2) OR [CADISPRIORITY]=(3))
);


GO
CREATE CLUSTERED INDEX [IDXDM_MP2_SOURCE20_PKRID2]
    ON [CADIS_PROC].[DM_MP2_SOURCE20]([UNIQUE_IDENTIFIER] ASC, [CADISROWID] ASC, [CADISID] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDXDM_MP2_SOURCE20]
    ON [CADIS_PROC].[DM_MP2_SOURCE20]([UNIQUE_IDENTIFIER] ASC);


GO
CREATE NONCLUSTERED INDEX [IDXDM_MP2_SOURCE20_CRID]
    ON [CADIS_PROC].[DM_MP2_SOURCE20]([CADISROWID] ASC);


GO
CREATE NONCLUSTERED INDEX [IDXDM_MP2_SOURCE20_CID]
    ON [CADIS_PROC].[DM_MP2_SOURCE20]([CADISID] ASC);


GO
CREATE NONCLUSTERED INDEX [IDXDM_MP2_SOURCE20_PKID]
    ON [CADIS_PROC].[DM_MP2_SOURCE20]([UNIQUE_IDENTIFIER] ASC);


GO
CREATE NONCLUSTERED INDEX [IDXDM_MP2_SOURCE20_PKRID]
    ON [CADIS_PROC].[DM_MP2_SOURCE20]([UNIQUE_IDENTIFIER] ASC, [CADISROWID] ASC);


GO
	
		CREATE TRIGGER [CADIS_PROC].[TRGDM_MP2_SOURCE20_REVISION] ON "CADIS_PROC"."DM_MP2_SOURCE20" 
		FOR insert/*sp_password*/,update/*sp_password*/
		AS
			insert/*sp_password*/
			INTO	"CADIS_PROC"."DM_MP2_SOURCE20_REVISION"
				(
					"UNIQUE_IDENTIFIER"	,
					[REVISION] 	,
					[REVISIONEFFECTIVE],
					[CADISID],
					[CADISROWID]
				)
				select/*sp_password*/	MP."UNIQUE_IDENTIFIER",
					ISNULL(RV.REVISION,0) + 1,
					MP.CADISUPDATED,
					MP.CADISID,
					MP.CADISROWID
				FROM	INSERTED AS MP
					LEFT OUTER JOIN DELETED AS SR
								ON SR."UNIQUE_IDENTIFIER" = MP."UNIQUE_IDENTIFIER"
					LEFT OUTER JOIN (	select/*sp_password*/	"UNIQUE_IDENTIFIER", MAX(REVISION) AS REVISION
								FROM	"CADIS_PROC"."DM_MP2_SOURCE20_REVISION" 
								GROUP BY "UNIQUE_IDENTIFIER"	) RV
						ON RV."UNIQUE_IDENTIFIER" = MP."UNIQUE_IDENTIFIER"
				WHERE	MP.CADISID <> ISNULL(SR.CADISID,0)
		