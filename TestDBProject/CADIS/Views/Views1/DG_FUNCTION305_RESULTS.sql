﻿CREATE VIEW "CADIS"."DG_FUNCTION305_RESULTS" AS 
SELECT ET."BrokerAttestationEventId",ET."BrokerAttestationId",ET."BrokerAttestationEventType",ET."EventDetails",ET."EventDate",ET."SubmittedByPersonId",ET."DocumentationFolderLink",ET."JoinGUID",ET."BrokerAttestationEventCreationDatetime",ET."BrokerAttestationEventLastModifiedDatetime",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Organisation"."BrokerAttestationEvents" ET WITH (NOLOCK)