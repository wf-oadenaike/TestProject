﻿CREATE VIEW "CADIS"."ILT_T_BBG_RISK_FieldLinks" AS 
select TEMPLATE_ILL_FIELDS.* from 
(SELECT tp.NAME as TEMPLATE_NAME ,t.[TEMPLATEFIELDNAME] as TEMPLATE_FIELDNAME, T.TEMPLATEDESC AS TEMPLATE_DESC, T.TEMPLATEFIELDTYPE AS TEMPLATE_FIELD_TYPE, T.TEMPLATEFORMAT AS TEMPLATE_FORMAT, s.ILLFIELDNAME, sp.name as ILLNAME
FROM CADIS_SYS.IL_TEMPLATEFIELDS t
join CADIS_SYS.VW_ALL_PROCESSES tp on tp.GUID='b9cab536d228488c8b47d938245a2f96' AND tp.IDENTIFIER = t.TEMPLATEID and tp.COMPONENTID=7
join CADIS_SYS.IL_ILLUSTRATORFIELDS s on s.TEMPLATEFIELDNAME=t.TEMPLATEFIELDNAME AND s.TEMPLATEID = t.TEMPLATEID
join CADIS_SYS.VW_ALL_PROCESSES sp on sp.IDENTIFIER = s.ILLUSTRATORID and sp.COMPONENTID=6 ) flds
PIVOT
(   MAX(flds.ILLFIELDNAME)
FOR flds.illName IN ([T_BBG_RISK])
) AS TEMPLATE_ILL_FIELDS	
