CREATE VIEW [Access.ManyWho].[ShareClassesReadOnlyVw]
	AS 
SELECT
	   sc.ShareClassId
	 , sc.MandateId
	 , m.MandateName
	 , m.PortfolioCode
	 , sc.ShareClass
  FROM [Investment].[ShareClass] sc
  INNER JOIN [Investment].[Mandates] m
  ON sc.MandateId = m.MandateId

  ;
