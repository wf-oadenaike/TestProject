CREATE VIEW "CADIS"."ILT_Organisation_FieldLinks" AS 
select TEMPLATE_ILL_FIELDS.* from 
(SELECT tp.NAME as TEMPLATE_NAME ,t.[TEMPLATEFIELDNAME] as TEMPLATE_FIELDNAME, T.TEMPLATEDESC AS TEMPLATE_DESC, T.TEMPLATEFIELDTYPE AS TEMPLATE_FIELD_TYPE, T.TEMPLATEFORMAT AS TEMPLATE_FORMAT, s.ILLFIELDNAME, sp.name as ILLNAME
FROM CADIS_SYS.IL_TEMPLATEFIELDS t
join CADIS_SYS.VW_ALL_PROCESSES tp on tp.GUID='7fb2d892beb3459ca9f09736caa06b61' AND tp.IDENTIFIER = t.TEMPLATEID and tp.COMPONENTID=7
join CADIS_SYS.IL_ILLUSTRATORFIELDS s on s.TEMPLATEFIELDNAME=t.TEMPLATEFIELDNAME AND s.TEMPLATEID = t.TEMPLATEID
join CADIS_SYS.VW_ALL_PROCESSES sp on sp.IDENTIFIER = s.ILLUSTRATORID and sp.COMPONENTID=6 ) flds
PIVOT
(   MAX(flds.ILLFIELDNAME)
FOR flds.illName IN ([Organisation Broker On Boarding Event Types],[Organisation Broker On Boarding Events],[Organisation Broker On Boarding Register],[Organisation Meeting Agenda Items],[Organisation Meeting Attendees],[Organisation Meeting Occurrence],[Organisation Meeting Occurrence JIRA Issue],[Organisation Meetings Register],[Organisation Policy Theme Events],[Organisation Policy Theme Procedures],[Organisation Policy Theme Register],[Organisation Project Aspects],[Organisation Projects Register],[Organisation Unquoted Companies],[Organisation Unquoted Company Additional Info],[Organisation Unquoted Company Commentaries],[Organisation Unquoted Company Completion Checklist],[Organisation Unquoted Company Decisions],[Organisation Unquoted Company Investment],[Organisation Unquoted Company Revaluation],[Organisation Unquoted Company Stage Roles],[Organisation Unquoted Company Stages],[Organisation Unquoted Securities],[Organisation Unquoted Securities Fund Investments],[Organisation Valuation Reviews])
) AS TEMPLATE_ILL_FIELDS	
