﻿CREATE VIEW "CADIS"."ILT_Daily_Performance_FieldLinks" AS 
select TEMPLATE_ILL_FIELDS.* from 
(SELECT tp.NAME as TEMPLATE_NAME ,t.[TEMPLATEFIELDNAME] as TEMPLATE_FIELDNAME, T.TEMPLATEDESC AS TEMPLATE_DESC, T.TEMPLATEFIELDTYPE AS TEMPLATE_FIELD_TYPE, T.TEMPLATEFORMAT AS TEMPLATE_FORMAT, s.ILLFIELDNAME, sp.name as ILLNAME
FROM CADIS_SYS.IL_TEMPLATEFIELDS t
join CADIS_SYS.VW_ALL_PROCESSES tp on tp.GUID='cca22fd0eebd4d808ecbb4ad2f9bbde5' AND tp.IDENTIFIER = t.TEMPLATEID and tp.COMPONENTID=7
join CADIS_SYS.IL_ILLUSTRATORFIELDS s on s.TEMPLATEFIELDNAME=t.TEMPLATEFIELDNAME AND s.TEMPLATEID = t.TEMPLATEID
join CADIS_SYS.VW_ALL_PROCESSES sp on sp.IDENTIFIER = s.ILLUSTRATORID and sp.COMPONENTID=6 ) flds
PIVOT
(   MAX(flds.ILLFIELDNAME)
FOR flds.illName IN ([Daily Fund Performance])
) AS TEMPLATE_ILL_FIELDS	
