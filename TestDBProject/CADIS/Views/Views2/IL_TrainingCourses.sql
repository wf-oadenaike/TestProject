﻿CREATE VIEW "CADIS"."IL_TrainingCourses" AS 
SELECT V."TrainingCourseId" AS "Training Course Id",V."TrainingTitle" AS "Training Title", J2.DF AS "Training Type Id",V."AttestationRequiredYesNo" AS "Attestation Required",V."AnnualTrainingYesNo" AS "Annual Training", J5.DF AS "Attendance Approver",V."AttestationText" AS "Attestation Text",V."IsActive" AS "Is Active",V."TrainingCourseCreationDate" AS "Training Course Creation Date",V."TrainingCourseLastModifiedDate" AS "Training Course Last Modified Date",V."CADIS_SYSTEM_INSERTED" AS "Inserted",V."CADIS_SYSTEM_UPDATED" AS "Updated",V."CADIS_SYSTEM_CHANGEDBY" AS "Changed By" FROM "Compliance"."TrainingCourses" V LEFT OUTER JOIN (SELECT DISTINCT "TrainingTypeId" AS JF,"TrainingType" AS DF FROM "Compliance"."TrainingTypes")  J2 ON  J2.JF=V."TrainingTypeId" LEFT OUTER JOIN (SELECT DISTINCT "PersonId" AS JF,"PersonsName" AS DF FROM "Core"."PersonsActiveVw")  J5 ON  J5.JF=V."AttendanceApproverPersonId"
