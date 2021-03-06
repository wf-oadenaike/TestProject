﻿CREATE TABLE [CADIS_PROC].[DM_MP2_SOURCE243] (
    [INSTRUMENT_UII] VARCHAR (12)   NOT NULL,
    [CADISID]        INT            NOT NULL,
    [CADISPRIORITY]  TINYINT        CONSTRAINT [DF_DM_MP2_SOURCE243_PRIORITY] DEFAULT ((2)) NOT NULL,
    [CADISINSERTED]  DATETIME       NOT NULL,
    [CADISUPDATED]   DATETIME       NOT NULL,
    [CADISCHANGEDBY] NVARCHAR (100) NOT NULL,
    [CADISROWID]     INT            IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [CK_DM_MP2_SOURCE243_PRIORITY] CHECK ([CADISPRIORITY]=(1) OR [CADISPRIORITY]=(2) OR [CADISPRIORITY]=(3))
);


GO
CREATE CLUSTERED INDEX [IDXDM_MP2_SOURCE243_PKRID2]
    ON [CADIS_PROC].[DM_MP2_SOURCE243]([INSTRUMENT_UII] ASC, [CADISROWID] ASC, [CADISID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDXDM_MP2_SOURCE243]
    ON [CADIS_PROC].[DM_MP2_SOURCE243]([INSTRUMENT_UII] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDXDM_MP2_SOURCE243_CRID]
    ON [CADIS_PROC].[DM_MP2_SOURCE243]([CADISROWID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDXDM_MP2_SOURCE243_CID]
    ON [CADIS_PROC].[DM_MP2_SOURCE243]([CADISID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDXDM_MP2_SOURCE243_PKID]
    ON [CADIS_PROC].[DM_MP2_SOURCE243]([INSTRUMENT_UII] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDXDM_MP2_SOURCE243_PKRID]
    ON [CADIS_PROC].[DM_MP2_SOURCE243]([INSTRUMENT_UII] ASC, [CADISROWID] ASC) WITH (FILLFACTOR = 80);


GO
	
		CREATE TRIGGER [CADIS_PROC].[TRGDM_MP2_SOURCE243_REVISION] ON "CADIS_PROC"."DM_MP2_SOURCE243" 
		FOR INSERT,UPDATE
		AS
			INSERT
			INTO	"CADIS_PROC"."DM_MP2_SOURCE243_REVISION"
				(
					"INSTRUMENT_UII"	,
					[REVISION] 	,
					[REVISIONEFFECTIVE],
					[CADISID],
					[CADISROWID]
				)
				SELECT	MP."INSTRUMENT_UII",
					ISNULL(RV.REVISION,0) + 1,
					MP.CADISUPDATED,
					MP.CADISID,
					MP.CADISROWID
				FROM	INSERTED AS MP
					LEFT OUTER JOIN DELETED AS SR
								ON SR."INSTRUMENT_UII" = MP."INSTRUMENT_UII"
					LEFT OUTER JOIN (	SELECT	"INSTRUMENT_UII", MAX(REVISION) AS REVISION
								FROM	"CADIS_PROC"."DM_MP2_SOURCE243_REVISION" 
								GROUP BY "INSTRUMENT_UII"	) RV
						ON RV."INSTRUMENT_UII" = MP."INSTRUMENT_UII"
				WHERE	MP.CADISID <> ISNULL(SR.CADISID,0)
		