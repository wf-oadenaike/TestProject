
Create View V_REF_SALES_FORCE_POST_CODE_OWNER
as

Select S.POST_CODE,
	   S.FullEmployeeBK,
	   N.PersonsName
FROM [Core].[Persons] N
inner join 
(
	-- Use value in override if it is available.
	select isnull(O.POST_CODE,P.POST_CODE)					AS POST_CODE,
		   Isnull(o.FullEmployeeBK, P.FullEmployeeBK)		as FullEmployeeBK
	from dbo.T_REF_SALES_FORCE_POST_CODE_OWNER P
	left outer join 
	(
	select	LEFT(BillingPostcode, LEN(BillingPostcode) - 2) AS POST_CODE, 
			o.AccountOwnerId								AS FullEmployeeBK
	from T_SALESFORCE_POSTCODE_OVERRIDE O
	where OverrideStatus in ('Fixed','Exported')
	and o.BillingPostcode is not null
	) O
	on P.POST_CODE = O.POST_CODE
) S
on N.FullEmployeeBK = S.FullEmployeeBK
and N.ActiveFlag = 1
