

CREATE VIEW [dbo].[V_REF_UNQUOTED_FUND]
AS
SELECT 

 refLookup.FIELD_VALUE as	NAME
,refLookup.LOOKUP_VALUE as VALUE

FROM

"dbo"."T_REF_LOOKUP" refLookup

WHERE	refLookup.ENTITY = 'UNQUOTED'
and		refLookup.SUB_ENTITY = 'FUND'
and		refLookup.FIELD = 'UNQUOTED FUNDS'

