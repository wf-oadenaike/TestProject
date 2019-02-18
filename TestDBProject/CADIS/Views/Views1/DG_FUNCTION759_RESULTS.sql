﻿CREATE VIEW "CADIS"."DG_FUNCTION759_RESULTS" AS 
SELECT ET."KPIID",ET."KPIGroupId",ET."KPIGroupName",ET."KPIName",ET."KPIDescription",ET."IsPercentage",ET."KPIValue",ET."OwnerRoleName",ET."PercentageOverThresholdRed",ET."PercentageOverThresholdAmber",ET."PercentageOverThresholdGreen",ET."RedThresholdValue",ET."AmberThresholdValue",ET."GreenThresholdValue",ET."IsRed",ET."IsAmber",ET."IsGreen",ET."FrequencyName",ET."LastUpdatedDate",ET."RiskCategory",ET."RiskSubCategory",ET."MaxLastUpdatedDate" FROM "Access.ManyWho"."KRILatestDataVw" ET WITH (NOLOCK)