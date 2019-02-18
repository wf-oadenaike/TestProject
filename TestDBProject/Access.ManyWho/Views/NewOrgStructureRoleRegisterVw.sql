

CREATE VIEW [Access.ManyWho].[NewOrgStructureRoleRegisterVw]
	AS 
SELECT
	RR.RoleId,
	RR.Name as RoleName,
	RR.CircleID,
	SC.Name as CircleName,
	RR.Purpose,
	RR.IsActive

FROM [dbo].[NewOrgStructureRoles]  RR

INNER JOIN [dbo].[NewOrgStructureCircles] SC
ON RR.CircleID = SC.CircleID

