CREATE proc zzz_USP_Matrix_ContactPatch
as
-- Temporary proc to handle Matrix data issues.
-- Unclassified exceptions

DELETE FROM A
FROM [dbo].[t_MATRIX_CONTACT] A
LEFT OUTER JOIN
(
-- Data excecptions
select * from [dbo].[t_MATRIX_CONTACT] a
where salesforce_account_id != '00120000017yhgDAAQ'  -- Should have not been sent
and MX_MATRIX_CONTACT_ID is not null 
and (is_prospect = 'Y' or is_update = 'Y') -- New or updates
) e
on a.SALESFORCE_CONTACT_ID =  e.SALESFORCE_CONTACT_ID
and a.MX_CONTACT_SIV_ID = e.MX_CONTACT_SIV_ID
and a.AS_AT_DATE = e.AS_AT_DATE
WHERE e.SALESFORCE_CONTACT_ID IS NULL
