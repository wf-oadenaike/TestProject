Create View CADIS.vwProcessLog
--WITH ENCRYPTION--cadisbuild
As
/*
	Show details from the co_processlog table, including component types and names
*/
Select L.*, H.PROCESSTYPE, H.PROCESSNAME
From cadis_sys.CO_PROCESSLOG L
Join CADIS.vwProcessHistory H On H.runid = L.runid
