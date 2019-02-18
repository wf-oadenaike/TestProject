CREATE VIEW "CADIS"."DG_FUNCTION175_RESULTS" AS 
SELECT ET."RiskOwnerId",ET."RiskOwner",ET."RiskOwnerRoleId",ET."RiskOwnerRole" FROM "Access.ManyWho"."RiskOwnersVw" ET WITH (NOLOCK)
