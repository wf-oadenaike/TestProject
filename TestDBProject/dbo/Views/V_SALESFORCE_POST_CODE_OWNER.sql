
Create View V_SALESFORCE_POST_CODE_OWNER
as

Select S.POST_CODE,
	   S.FullEmployeeBK,
	   N.PersonsName
FROM [Core].[Persons] N
inner join T_REF_SALES_FORCE_POST_CODE_OWNER S
on N.FullEmployeeBK = S.FullEmployeeBK
and N.ActiveFlag = 1