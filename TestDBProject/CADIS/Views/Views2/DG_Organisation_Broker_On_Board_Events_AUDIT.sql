CREATE VIEW "CADIS"."DG_Organisation_Broker_On_Board_Events_AUDIT" AS 
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
		,[KEY_BrokerOnBoardingRegisterId]
		,[KEY_BrokerOnBoardingEventTypeId]
		,[KEY_PersonId]
		,[KEY_RoleId]
		,[KEY_DepartmentId]
		,[KEY_BrokerOnBoardingEventCreationDatetime]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT405"
