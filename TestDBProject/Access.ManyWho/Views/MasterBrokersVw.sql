
CREATE VIEW [Access.ManyWho].[MasterBrokersVw]
	AS 
SELECT rbr.ResearchBrokerId -- as MasterBrokerId
     , rbr.BloombergId
	 , rbr.BrokerCompanyName as BrokerName
     , bst.ServiceType
	 , rbr.ResearchAccountSalesforceId  
	 , (SELECT TOP 1 bobr.ExecutionAccountSalesforceId 
	    FROM [Organisation].[BrokerOnBoardingRegister] bobr
	    INNER JOIN [Investment].[T_MASTER_PTY] childpty
		ON childpty.party_code = bobr.BloombergId
		INNER JOIN [Investment].[T_MASTER_PTY_RELATIONSHIP] mprel
		ON childpty.edm_pty_id = mprel.related_edm_pty_id
		AND mprel.relationship_type = 'Parent'
		INNER JOIN [Investment].[T_MASTER_PTY] parentpty
		ON mprel.edm_pty_id = parentpty.edm_pty_id
		AND parentpty.party_code = rbr.BloombergId) as ExecutionAccountSalesforceId 
FROM [Investment].[ResearchBrokerRegister] rbr
INNER JOIN [Organisation].[BrokerServiceTypes] bst
ON rbr.BrokerServiceTypeId = bst.ServiceTypeId
UNION ALL
SELECT DISTINCT mp.edm_pty_id -- as MasterBrokerId
     , mp.party_code as BloombergId
     , mp.party_short_name as BrokerName
	 , 'Execution only' as ServiceType
	 , NULL as ResearchAccountSalesforceId
	 , (SELECT TOP 1 bobr.ExecutionAccountSalesforceId 
	    FROM [Organisation].[BrokerOnBoardingRegister] bobr
	    INNER JOIN [Investment].[T_MASTER_PTY] childpty
		ON childpty.party_code = bobr.BloombergId
		INNER JOIN [Investment].[T_MASTER_PTY_RELATIONSHIP] mprel
		ON childpty.edm_pty_id = mprel.related_edm_pty_id
		AND mprel.relationship_type = 'Parent'
		INNER JOIN [Investment].[T_MASTER_PTY] parentpty
		ON mprel.edm_pty_id = parentpty.edm_pty_id
		AND parentpty.party_code = mp.party_code) as ExecutionAccountSalesforceId 
FROM [Investment].[T_MASTER_PTY] mp
INNER JOIN [Investment].[T_MASTER_PTY_ROLE] mpr
ON mpr.edm_pty_id = mp.edm_pty_id
AND mpr.role_type = 'Broker'
INNER JOIN [Investment].[T_MASTER_PTY_RELATIONSHIP] mprel
ON mprel.edm_pty_id = mp.edm_pty_id
AND mprel.relationship_type = 'Parent'
WHERE mp.party_code NOT IN (SELECT DISTINCT BloombergId 
                           FROM [Investment].[ResearchBrokerRegister]
						   WHERE BloombergId IS NOT NULL)

;
