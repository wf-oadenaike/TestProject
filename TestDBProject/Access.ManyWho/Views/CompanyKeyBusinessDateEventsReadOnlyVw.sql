CREATE VIEW [Access.ManyWho].[CompanyKeyBusinessDateEventsReadOnlyVw]
	AS 
SELECT 
       ckbdr.CompanyKeyBusinessDateId
	 , ckbdr.BusinessActivity
	 , ckbdr.BusinessActivityTypeId
	 , cbat.BusinessActivityType  
	 , ckbdr.FinancialYearReference
	 , rp.PersonsName as ReporterName
	 , ckbdr.ReporterRoleId
	 , rp.AssignedRoleName as ReporterRole
	 , ap.PersonsName as AssigneePerson
	 , ckbdr.AssigneeRoleId
	 , ap.AssignedRoleName as AssigneeRole	 
	 , ckbde.CompanyKeyBusinessDateEventId
	 , ckbde.FinancialYear
	 , ckbde.EventDate
	 , ckbde.DueDate
	 , ckbde.ClosedDate
	 , CASE WHEN ckbde.ClosedDate IS NULL THEN 'Open' ELSE 'Closed' END as Status
	 , ckbde.CompanyKeyBusinessDateEventCreationDatetime as CreatedDate
  FROM [Organisation].[CompanyKeyBusinessDateRegister] ckbdr
  INNER JOIN [Organisation].[CompanyKeyBusinessDateEvents] ckbde
  ON ckbdr.CompanyKeyBusinessDateId = ckbde.CompanyKeyBusinessDateId
  INNER JOIN [Organisation].[CompanyBusinessActivityTypes] cbat
  ON ckbdr.BusinessActivityTypeId = cbat.BusinessActivityTypeId
  LEFT OUTER JOIN [Access.ManyWho].[PersonsActiveVw] rp
  ON ckbdr.ReporterRoleId = rp.AssignedRoleId
  LEFT OUTER JOIN [Access.ManyWho].[PersonsActiveVw] ap
  ON ckbdr.AssigneeRoleId = ap.AssignedRoleId

  ;
