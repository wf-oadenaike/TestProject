Create View CADIS.vwSolutionProcess
--WITH ENCRYPTION--cadisbuild
As
/*
	Show top level information about the processes which ran in a solution
*/
Select PARENTSOLUTIONRUNID = SH.runid, SOLUTIONNAME=SH.NAME, H.*
From CADIS.vwProcessHistory H
Join CADIS.vwSolutionHistory SH On SH.RunID = H.ParentRunID
