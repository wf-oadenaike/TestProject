CREATE VIEW "CADIS"."ILT_Compliance_FieldLinks" AS 
select TEMPLATE_ILL_FIELDS.* from 
(SELECT tp.NAME as TEMPLATE_NAME ,t.[TEMPLATEFIELDNAME] as TEMPLATE_FIELDNAME, T.TEMPLATEDESC AS TEMPLATE_DESC, T.TEMPLATEFIELDTYPE AS TEMPLATE_FIELD_TYPE, T.TEMPLATEFORMAT AS TEMPLATE_FORMAT, s.ILLFIELDNAME, sp.name as ILLNAME
FROM CADIS_SYS.IL_TEMPLATEFIELDS t
join CADIS_SYS.VW_ALL_PROCESSES tp on tp.GUID='485d9f9957d64394b1dd487b92c195a4' AND tp.IDENTIFIER = t.TEMPLATEID and tp.COMPONENTID=7
join CADIS_SYS.IL_ILLUSTRATORFIELDS s on s.TEMPLATEFIELDNAME=t.TEMPLATEFIELDNAME AND s.TEMPLATEID = t.TEMPLATEID
join CADIS_SYS.VW_ALL_PROCESSES sp on sp.IDENTIFIER = s.ILLUSTRATORID and sp.COMPONENTID=6 ) flds
PIVOT
(   MAX(flds.ILLFIELDNAME)
FOR flds.illName IN ([Compliance Complaints Register],[Compliance Complaints Register Events],[Compliance Conflicts Register Action Types],[Compliance Conflicts Register Actions],[Compliance Conflicts Register Categories],[Compliance Conflicts Register Clients],[Compliance Conflicts Register Events],[Compliance Conflicts Register Generics],[Compliance Conflicts Register Identification],[Compliance Conflicts Register Meetings],[Compliance Conflicts Register Mitigation],[Compliance Conflicts Register Potential],[Compliance Conflicts Register User Interactions],[Compliance Conflicts Register UserInteractionTypes],[Compliance EBI External Bodies],[Compliance EBI Register],[Compliance EBI Register Event Types],[Compliance EBI Register Events],[Compliance EBI Register User Interaction Types],[Compliance EBI Register User Interactions],[Compliance PA Dealing Request Events],[Compliance PA Dealing Request Register])
) AS TEMPLATE_ILL_FIELDS	
