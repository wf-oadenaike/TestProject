﻿CREATE VIEW "CADIS"."DG_FUNCTION261_RESULTS" AS 
SELECT ET."PolicyId",ET."PolicyName",ET."Version",ET."Status",ET."SummaryDescription",ET."ReviewFrequencyId",ET."ReviewFrequencyName",ET."LastReviewDate",ET."NextReviewDate",ET."IsActive",ET."OwnerRoleId",ET."OwnerRole",ET."OwnerPersonId",ET."OwnerPerson",ET."ModifiedByPersonId",ET."ModifiedByPerson",ET."IsCEOSignatory",ET."DocumentCategoryId",ET."CategoryDescription",ET."DocumentationFolderLink",ET."JoinGUID",ET."PolicyRegisterCreationDatetime",ET."PolicyRegisterLastModifiedDatetime",ET."IsBCP" FROM "Access.ManyWho"."PolicyRegisterReadOnlyVw" ET WITH (NOLOCK)