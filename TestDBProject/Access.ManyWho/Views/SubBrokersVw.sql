
CREATE VIEW [Access.ManyWho].[SubBrokersVw]
	AS 
SELECT mp.edm_pty_id
     , mp.party_code as BloombergId
	 , mp.party_short_name as BrokerName
     , pmp.party_code as MasterBloombergId
	 , pmp.party_short_name as MasterBrokerName
	 , CASE WHEN (SELECT DISTINCT 1
                  FROM [Organisation].[BrokerRestrictions] br
                  WHERE br.BloombergId = mp.party_code
                  AND ISNULL([RestrictionActive],0)=1) =1 THEN 'Inactive'
            WHEN mp.[Active?] = 0 THEN 'Inactive'
			WHEN mp.[Approved?] = 0 THEN 'Not Approved'
			ELSE 'Approved' END as BrokerStatus
	 , bobr.ExecutionAccountSalesforceId
FROM [Investment].[T_MASTER_PTY] mp
INNER JOIN [Investment].[T_MASTER_PTY_ROLE] mpr
ON mpr.edm_pty_id = mp.edm_pty_id
AND mpr.role_type = 'Broker'
INNER JOIN [Investment].[T_MASTER_PTY_RELATIONSHIP] mprel
ON mprel.related_edm_pty_id = mp.edm_pty_id
AND mprel.relationship_type = 'Parent'
INNER JOIN [Investment].[T_MASTER_PTY] pmp
ON mprel.edm_pty_id = pmp.edm_pty_id
LEFT OUTER JOIN [Organisation].[BrokerOnBoardingRegister] bobr
ON bobr.BloombergId = mp.party_code
UNION
SELECT bobr.BrokerOnBoardingRegisterId
     , bobr.BloombergId
     , bobr.BrokerCompanyName as BrokerName
     , bobr.MasterBloombergId
	 , mpty.party_short_name as MasterBrokerName	
	 , bobr.BrokerOnBoardingStatus as BrokerStatus
	 , bobr.ExecutionAccountSalesforceId
FROM [Organisation].[BrokerOnBoardingRegister] bobr
LEFT OUTER JOIN [Investment].[T_MASTER_PTY] mpty
ON bobr.MasterBloombergId = mpty.party_code
WHERE bobr.BloombergId IS NOT NULL 
AND bobr.BloombergId NOT IN (SELECT DISTINCT mp.party_code
                               FROM [Investment].[T_MASTER_PTY] mp
							   INNER JOIN [Investment].[T_MASTER_PTY_ROLE] mpr
                               ON mpr.edm_pty_id = mp.edm_pty_id
                               AND mpr.role_type = 'Broker')
UNION
SELECT bobr.BrokerOnBoardingRegisterId
     , bobr.BloombergId
     , bobr.BrokerCompanyName as BrokerName
     , bobr.MasterBloombergId
	 , mpty.party_short_name as MasterBrokerName	
	 , bobr.BrokerOnBoardingStatus as BrokerStatus
	 , bobr.ExecutionAccountSalesforceId
FROM [Organisation].[BrokerOnBoardingRegister] bobr
LEFT OUTER JOIN [Investment].[T_MASTER_PTY] mpty
ON bobr.MasterBloombergId = mpty.party_code
WHERE bobr.BloombergId IS NULL 

;
