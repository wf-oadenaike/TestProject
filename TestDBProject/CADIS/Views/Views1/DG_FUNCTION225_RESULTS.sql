﻿CREATE VIEW "CADIS"."DG_FUNCTION225_RESULTS" AS 
SELECT ET."TrainingTypeId",ET."TrainingType",ET."JoinGUID",ET."TrainingTypeCreationDate",ET."TrainingTypeLastModifiedDate",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Compliance"."TrainingTypes" ET WITH (NOLOCK)