CREATE VIEW "CADIS"."DG_PolicyProc_ProcDocument_To_Document_Relationship_AUDIT" AS 
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
		,[KEY_ProcDocumentId1]
		,[KEY_ProcDocumentId2]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT251"
