CREATE PROCEDURE [Organisation].[usp_AMeetingAgendaitems]
	 @RunDate DATE = NULL
AS
BEGIN

-- Return a list of issues to create in Jira.  If you call this twice on the same day you create 2 lots of the same issues.
			SELECT ma.MeetingAgendaItemId, mo.MeetingOccurrenceId, m.MeetingNameBK as MeetingName, ma.AgendaItemNameBK as Summary, ma.AgendaItemDetails as [Description]
				, ma.ReporterRoleId, rp.PersonsName as ReporterPersonsName
				, SubString( rp.ContactEmailAddress, 1, CHARINDEX( '@', rp.ContactEmailAddress)-1) 
					as ReporterContactEmailAddress
				, ma.AssigneeRoleId, ap.PersonsName as AssigneePersonsName
				, SUBSTRING( ap.ContactEmailAddress, 1, CHARINDEX( '@', ap.ContactEmailAddress)-1) 
					as AssigneeContactEmailAddress
				, m.JIRAProjectKey AS ProjectKey, mo.JIRAEpicKey as MeetingOccurrenceEpic, j.JIRABK as IssueType, FORMAT( DATEADD( d, ISNULL(ma.[LagLead],jl.[LagLead]), mo.MeetingDateTime), 'yyyy-MM-ddThh:mm:ss' ) as DueDate, mo.MeetingDateTime
				,ISNULL(ma.[LagLead],jl.[LagLead]) as LagLead
		FROM [Organisation].MeetingOccurrence mo
			INNER JOIN [Organisation].MeetingsRegister m
				ON mo.MeetingRegisterId = m.MeetingRegisterId
			INNER JOIN [Organisation].[MeetingAgendaItems] ma
				ON m.MeetingRegisterId = ma.MeetingRegisterId
			LEFT OUTER JOIN [Organisation].[JiraIssueTypes] j
				ON ma.IssueType = j.TypeName
			LEFT OUTER JOIN [Organisation].[MeetingJiraIssueTypeLag] jl
			ON jl.IssueTypeId = j.IssueTypeId
			INNER JOIN [Core].[RolePersonRelationship] rrp
				ON ma.ReporterRoleId = rrp.RoleId
				AND rrp.ActiveFlag = 1
			INNER JOIN [Core].[Persons] rp
				ON rrp.PersonId = rp.PersonId
					AND rp.ActiveFlag = 1
			INNER JOIN [Core].[RolePersonRelationship] arp
				ON ma.AssigneeRoleId = arp.RoleId
				AND arp.ActiveFlag = 1
				INNER JOIN [Core].[Persons] ap
					ON arp.PersonId = ap.PersonId
					AND ap.ActiveFlag =1
			LEFT JOIN [Organisation].[MeetingOccurrenceJiraIssueCreationLog] mojicl ON mojicl.MeetingAgendaItemId = 
				ma.MeetingAgendaItemId AND  mojicl.MeetingOccurrenceId = mo.MeetingOccurrenceId
			WHERE m.ActiveFlag = 1
			AND ma.ActiveFlag = 1
			AND mojicl.MeetingOccurrenceId IS NULL
			AND (CONVERT(DATE, DATEADD(d, - m.LagDays, mo.MeetingDateTime)) = @RunDate OR (@RunDate IS NULL AND (CONVERT(DATE, DATEADD(d, - m.LagDays, mo.MeetingDateTime)) = CONVERT(DATE, GETDATE())))
			)

END
