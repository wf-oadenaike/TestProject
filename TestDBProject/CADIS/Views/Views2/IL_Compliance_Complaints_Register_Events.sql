﻿CREATE VIEW "CADIS"."IL_Compliance_Complaints_Register_Events" AS 
SELECT V."ComplaintsRegisterEventId" AS "Complaints Register Event ID",V."ComplaintRegisterId" AS "Complaint Register ID",V."ComplaintEventTypeId" AS "Complaint Event Type ID",V."RecordedByPersonId" AS "Recorded By Person ID",V."EventDetails" AS "Event Details",V."EventDate" AS "Event Date",V."EventTrueFalse" AS "Event True False",V."DocumentationFolderLink" AS "Documentation Folder Link",V."JoinGUID" AS "Join GUID",V."ComplaintEventCreationDate" AS "Complaint Event Creation Date",V."ComplaintEventLastModifiedDate" AS "Complaint Event Last Modified Date",V."CADIS_SYSTEM_INSERTED",V."CADIS_SYSTEM_UPDATED",V."CADIS_SYSTEM_CHANGEDBY",V."CADIS_SYSTEM_PRIORITY",V."CADIS_SYSTEM_TIMESTAMP",V."CADIS_SYSTEM_LASTMODIFIED" FROM "Compliance"."ComplaintsRegisterEvents" V