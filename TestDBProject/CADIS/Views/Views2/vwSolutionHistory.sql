﻿Create View CADIS.vwSolutionHistory
--WITH ENCRYPTION--cadisbuild
As
/*
	Show details from the co_solutionhistory table, including solution names
*/
Select PH.*, RUNTIME=PH.RUNEND-PH.RUNSTART, S.NAME, 
	LASTLOGENTRY=CASE WHEN PH.RUNEND IS NULL THEN ISNULL(LR.LASTLOGENTRY, PH.RUNSTART) ELSE NULL END,
	TIMESINCELASTENTRY=CASE WHEN PH.RUNEND IS NULL THEN GetDate()-ISNULL(LR.LASTLOGENTRY, PH.RUNSTART) ELSE NULL END,
	RUNCOMPLETE = CONVERT(bit, CASE WHEN PH.RUNEND IS NULL THEN 0 ELSE 1 END),
	TOPLEVEL=CASE PH.RunID WHEN PH.TopLevelRunID THEN 1 ELSE 0 END
From cadis_sys.CO_PROCESSHISTORY PH
Join cadis_sys.CO_SOLUTION S On S.guid = PH.guid and PH.componentID = 8 -- Solution
Left Join (SELECT PARENTSOLUTIONRUNID, LASTLOGENTRY=MAX(LogTime) FROM CADIS.vwSolutionDetail GROUP BY PARENTSOLUTIONRUNID) LR On LR.PARENTSOLUTIONRUNID = PH.RUNID