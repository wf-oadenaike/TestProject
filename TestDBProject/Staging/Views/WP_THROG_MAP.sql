

CREATE VIEW [Staging].[WP_THROG_MAP] as 
/*Wilson Partner to Throg MAP
Date 2017-06-28 
Change Project code source to use Organisation.NewProjectsRegister 
from Finance.AccountProjects
JIRA DAP-1180
Date 2017-08-22
Change to resolve JIRAEPICKEY 
JIRA DAP-1307
*/


Select wjl.JournalNumber as TRAN_NUMBER,
case when wjl.SourceType='MANJOURNAL' and wjl.NetAmount<0 then 'JC' 
	 when wjl.SourceType='MANJOURNAL' and wjl.NetAmount>0 then 'JD' 
	 else
(select SageName from Core.WP_Throg_Map where XeroName= wjl.SourceType and Mapname='Transaction' and  wjl.SourceType<>'MANJOURNAL' ) END as [TYPE],
-- wjl.SourceType,
wjl.JournalDate as [Date],
 wjl.Reference as ACCOUNT_REF,
 wjl.AccountCode as NOMINAL_CODE,
 NULL as BANK_CODE,
 wjl.REference as INV_REF,
 wjl.Description as DETAILS,
 --DEPT_NUMBER --LOOKUP

 (Select DepartmentNumber from [Core].[Departments] where DEpartmentName=wjl.Organisational) as DEPT_NUMBER,
 wjl.Organisational as DEPT_NAME,
 --wjl.TaxName as TAX_CODE,
 (select SageName from Core.WP_Throg_Map where XeroName= wjl.TaxName and Mapname='TaxCode') as TAX_CODE,
 wjl.NetAmount as AMOUNT,
 NULL as EXTRA_REF,
 Month(wjl.JournalDate) as [Month],
 Year(wjl.JournalDate) as [Year],
 DATENAME(month, wjl.JournalDate) as [Period] ,
 wjnd.contactName as [Supplier/Customer], 
case when wjl.accountcode>=4000 then  'P&L' else 'BS' end as [PnL/BS],
(select SageName from Core.WP_Throg_Map where XeroName= wjl.AccountName and Mapname='AccountCategory') as AccountCategory,
wjl.AccountName as [ACCOUNT NAME],
--AP.projectcode as  PROJECT_ID,
(Select distinct JiraEpicKey as ProjectCode from  [Organisation].[NewProjectsRegister] 
where  ProjectName=wjl.Projects and wjl.Projects
 is not null 
 and JiraEpicKey is not null
  and wjl.Projects<>'Flexible benefits' ) as PROJECT_ID,
wjl.Projects as PROJECT_NAME,
'LLP' as Entity,
case when wjld.JournalLineID is not null then 'D' else 'ND' end as Disc_Flag,
wjl.JournalLineID
from [Staging].[WP_JournalLines] wjl
left join [Staging].[WP_JournalLinesDiscretionary] wjld
on wjl.[JournalLineID]=wjld.[JournalLineID] 
--where wjl.Description='MEGRiVER MK Dec 16 Expenses'
-- where wjl.JournalLineID= 'ba76ee82-84f4-4c40-96f6-4315fff1d552'
left join [Staging].[WP_Joined]
wjnd on 
wjl.[JournalLineID]=wjnd.[JournalLineID] 
--left join [Finance].[AccountProjects] AP on AP.ProjectName=wjl.Projects
where wjl.accountcode>=4000



