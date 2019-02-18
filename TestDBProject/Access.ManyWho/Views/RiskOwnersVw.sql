CREATE VIEW [Access.ManyWho].[RiskOwnersVw]
	AS 
SELECT	PersonId AS RiskOwnerId
      , PersonsName AS RiskOwner
	  , AssignedRoleId AS RiskOwnerRoleId
	  , AssignedRoleName AS RiskOwnerRole
FROM [Access.ManyWho].[PersonsActiveVw]
WHERE [IsRiskOwner]=1
