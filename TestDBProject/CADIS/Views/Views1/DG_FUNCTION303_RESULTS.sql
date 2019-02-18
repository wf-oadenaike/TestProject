﻿CREATE VIEW "CADIS"."DG_FUNCTION303_RESULTS" AS 
SELECT ET."Id",ET."CntFcaId",ET."CntSalesforceId",ET."CntMatrixId",ET."CntSivId",ET."CntSalutation",ET."CntFirstName",ET."CntLastName",ET."CntJobTitle",ET."CntLandline",ET."CntMobile",ET."CntFax",ET."CntEmail",ET."CntIsCf1",ET."CntIsCf2",ET."CntIsCf3",ET."CntIsCf4",ET."CntIsCf10",ET."CntIsCf11",ET."CntIsCf30",ET."WoodfordLastUpdate",ET."MatrixLastUpdate",ET."IsConfirmRequired",ET."IsReviewed",ET."StartDateTime",ET."EndDateTime",ET."IsActive",ET."ModifiedByPersonId",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Sales.BP"."WoodfordContact" ET WITH (NOLOCK)
