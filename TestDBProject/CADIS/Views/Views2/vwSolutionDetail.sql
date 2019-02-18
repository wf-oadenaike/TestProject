Create View CADIS.vwSolutionDetail
--WITH ENCRYPTION--cadisbuild
As
/*
	Show details from the process logs which were part of a solution run
*/
Select PARENTSOLUTIONRUNID = H.ParentRunID, L.*
From CADIS.vwProcessLog L
Join CADIS.vwProcessHistory H On H.runid = L.runid
Join CADIS_SYS.CO_PROCESSHISTORY PH ON PH.ComponentID=8 -- Solution
WHERE H.ParentRunID = PH.RunID
