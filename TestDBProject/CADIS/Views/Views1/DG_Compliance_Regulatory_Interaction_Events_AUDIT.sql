CREATE VIEW "CADIS"."DG_Compliance_Regulatory_Interaction_Events_AUDIT" AS 
	SELECT
		[ID]
		,[INSERTED]
		,[CHANGEDBY]
		,[FIELDNAME]
		,CASE
		 WHEN [ACTION] = 0 THEN 'Inserted'
		 WHEN [ACTION] = 1 THEN 'Updated'
		 ELSE 'Deleted' END AS [ACTION]
		,[OLDVALUE]
		,[NEWVALUE]
		,[VALIDATION]
		,[KEY_RegulatoryInteractionEventId]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT147"
