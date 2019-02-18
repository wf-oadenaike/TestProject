CREATE VIEW "CADIS"."ILT_Fund_Flow_FieldLinks" AS 
select TEMPLATE_ILL_FIELDS.* from 
(SELECT tp.NAME as TEMPLATE_NAME ,t.[TEMPLATEFIELDNAME] as TEMPLATE_FIELDNAME, T.TEMPLATEDESC AS TEMPLATE_DESC, T.TEMPLATEFIELDTYPE AS TEMPLATE_FIELD_TYPE, T.TEMPLATEFORMAT AS TEMPLATE_FORMAT, s.ILLFIELDNAME, sp.name as ILLNAME
FROM CADIS_SYS.IL_TEMPLATEFIELDS t
join CADIS_SYS.VW_ALL_PROCESSES tp on tp.GUID='42223292892b498c958b791e1af1c32b' AND tp.IDENTIFIER = t.TEMPLATEID and tp.COMPONENTID=7
join CADIS_SYS.IL_ILLUSTRATORFIELDS s on s.TEMPLATEFIELDNAME=t.TEMPLATEFIELDNAME AND s.TEMPLATEID = t.TEMPLATEID
join CADIS_SYS.VW_ALL_PROCESSES sp on sp.IDENTIFIER = s.ILLUSTRATORID and sp.COMPONENTID=6 ) flds
PIVOT
(   MAX(flds.ILLFIELDNAME)
FOR flds.illName IN ([Dummy MG Deals In Progress Source],[Dummy MG Gross Fund Flow Source],[Dummy MG Net Fund Flow Source],[Dummy MG Share Class Fund Flow Source],[Master Deals In Progress],[Master Fund Flow],[Master Fund Flow Discrepancy],[Master Gross Fund Flow],[Master Net Fund Flow],[Master Share Class Fund Flow],[Override Deals In Progress],[Override Deals In Progress Expiry],[Override Deals In Progress Reset],[Override Fund Flow],[Override Gross Fund Flow],[Override Gross Fund Flow Expiry],[Override Gross Fund Flow Reset],[Override Net Fund Flow],[Override Net Fund Flow Expiry],[Override Net Fund Flow Reset],[Override Share Class Fund Flow],[Override Share Class Fund Flow Expiry],[Override Share Class Fund Flow Reset],[Premaster Deals In Progress],[Premaster Gross Fund Flow],[Premaster Net Fund Flow],[Premaster Share Class Fund Flow])
) AS TEMPLATE_ILL_FIELDS	
