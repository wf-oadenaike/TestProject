
Create View [zzz_V_SALESFORCE_ACCOUNT_EXCEPTIONS]
as

SELECT	SFACCOUNTID,
	    'Postcode Owner Override'  as Exception_Type,
		AccountOwnerID
FROM T_SALESFORCE_POSTCODE_OVERRIDE
WHERE OVERRIDESTATUS = 'Exported' 


