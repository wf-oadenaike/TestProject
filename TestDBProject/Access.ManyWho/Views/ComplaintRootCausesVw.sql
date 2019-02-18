

CREATE VIEW [Access.ManyWho].[ComplaintRootCausesVw]
AS
SELECT rc.RootCauseId 
	 , rc.RootCause
	 , rc.RootCauseDescription
  FROM [Compliance].[ComplaintRootCauses] rc
