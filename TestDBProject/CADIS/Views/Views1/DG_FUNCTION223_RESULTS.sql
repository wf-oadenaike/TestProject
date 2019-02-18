﻿CREATE VIEW "CADIS"."DG_FUNCTION223_RESULTS" AS 
SELECT ET."TrainingCourseId",ET."TrainingTitle",ET."TrainingTypeId",ET."AttestationRequiredYesNo",ET."AnnualTrainingYesNo",ET."AttendanceApproverPersonId",ET."AttestationText",ET."IsActive",ET."JoinGUID",ET."TrainingCourseCreationDate",ET."TrainingCourseLastModifiedDate",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Compliance"."TrainingCourses" ET WITH (NOLOCK)