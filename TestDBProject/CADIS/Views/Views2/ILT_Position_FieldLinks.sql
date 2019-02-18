CREATE VIEW "CADIS"."ILT_Position_FieldLinks" AS 
select TEMPLATE_ILL_FIELDS.* from 
(SELECT tp.NAME as TEMPLATE_NAME ,t.[TEMPLATEFIELDNAME] as TEMPLATE_FIELDNAME, T.TEMPLATEDESC AS TEMPLATE_DESC, T.TEMPLATEFIELDTYPE AS TEMPLATE_FIELD_TYPE, T.TEMPLATEFORMAT AS TEMPLATE_FORMAT, s.ILLFIELDNAME, sp.name as ILLNAME
FROM CADIS_SYS.IL_TEMPLATEFIELDS t
join CADIS_SYS.VW_ALL_PROCESSES tp on tp.GUID='ce915a9b1fba434b938f500c542880d8' AND tp.IDENTIFIER = t.TEMPLATEID and tp.COMPONENTID=7
join CADIS_SYS.IL_ILLUSTRATORFIELDS s on s.TEMPLATEFIELDNAME=t.TEMPLATEFIELDNAME AND s.TEMPLATEID = t.TEMPLATEID
join CADIS_SYS.VW_ALL_PROCESSES sp on sp.IDENTIFIER = s.ILLUSTRATORID and sp.COMPONENTID=6 ) flds
PIVOT
(   MAX(flds.ILLFIELDNAME)
FOR flds.illName IN ([Dummy MG Fund Account Balance],[Dummy MG Fund Market Value Source],[Master Account Balance],[Master Fund Market Value],[Override Account Balance],[Override Account Balance Expiry],[Override Account Balance Reset],[Override Fund Market Value],[Override Fund Market Value Expiry],[Override Fund Market Value Reset],[Premaster Account Balance],[Premaster Fund Market Value])
) AS TEMPLATE_ILL_FIELDS	
