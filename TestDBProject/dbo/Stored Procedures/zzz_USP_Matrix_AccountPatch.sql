CREATE proc zzz_USP_Matrix_AccountPatch
as
-- Temporary proc to handle Matrix data issues.
-- Unclassified exceptions

DELETE FROM A
FROM [dbo].[t_MATRIX_ACCOUNT] A
LEFT OUTER JOIN
(
-- Data excecptions
select * from [dbo].[t_MATRIX_ACCOUNT] a
where MX_MATRIX_OUTLET_ID is not null
and (is_prospect = 'y' or is_update = 'y')  -- New or updates
) e
on a.SALESFORCE_ACCOUNT_ID =  e.SALESFORCE_ACCOUNT_ID
and a.MX_MATRIX_ACCOUNT_SIV_ID = e.MX_MATRIX_ACCOUNT_SIV_ID
and a.AS_AT_DATE = e.AS_AT_DATE
where e.SALESFORCE_ACCOUNT_ID is null

Update a
set MX_ACCOUNT_FSR_FRN = null
from [dbo].[t_MATRIX_ACCOUNT] a
where MX_ACCOUNT_FSR_FRN = 'unclassified'
