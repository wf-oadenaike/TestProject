﻿CREATE VIEW "CADIS"."ILT_Operation_FieldLinks" AS 
select TEMPLATE_ILL_FIELDS.* from 
(SELECT tp.NAME as TEMPLATE_NAME ,t.[TEMPLATEFIELDNAME] as TEMPLATE_FIELDNAME, T.TEMPLATEDESC AS TEMPLATE_DESC, T.TEMPLATEFIELDTYPE AS TEMPLATE_FIELD_TYPE, T.TEMPLATEFORMAT AS TEMPLATE_FORMAT, s.ILLFIELDNAME, sp.name as ILLNAME
FROM CADIS_SYS.IL_TEMPLATEFIELDS t
join CADIS_SYS.VW_ALL_PROCESSES tp on tp.GUID='ea8d68b171e1463eba8d6b9fb6fa31f6' AND tp.IDENTIFIER = t.TEMPLATEID and tp.COMPONENTID=7
join CADIS_SYS.IL_ILLUSTRATORFIELDS s on s.TEMPLATEFIELDNAME=t.TEMPLATEFIELDNAME AND s.TEMPLATEID = t.TEMPLATEID
join CADIS_SYS.VW_ALL_PROCESSES sp on sp.IDENTIFIER = s.ILLUSTRATORID and sp.COMPONENTID=6 ) flds
PIVOT
(   MAX(flds.ILLFIELDNAME)
FOR flds.illName IN ([Operation Corporate Actions Register],[Operation Placing Allocations],[Operation Placing Events],[Operation Placings Register],[Operation Proxy Voting Register])
) AS TEMPLATE_ILL_FIELDS	
