﻿CREATE VIEW "CADIS"."DG_FUNCTION31_RESULTS" AS 
SELECT ET."KPIFactId",ET."MeasureDateId",ET."KPIId",ET."MeasureValue",ET."LastUpdatedDatetime",ET."ControlId",ET."SourceSystemId",ET."RecordedBy",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Fact"."KPIFact" ET WITH (NOLOCK)
