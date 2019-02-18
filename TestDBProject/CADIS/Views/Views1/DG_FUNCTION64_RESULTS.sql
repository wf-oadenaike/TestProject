CREATE VIEW "CADIS"."DG_FUNCTION64_RESULTS" AS 
SELECT ET."User Login",ET."GROUPNAME" FROM "CADIS"."VW_SSO_Users_and_Groups" ET WITH (NOLOCK) WHERE (
"User Login" like '%woodford%'
)

