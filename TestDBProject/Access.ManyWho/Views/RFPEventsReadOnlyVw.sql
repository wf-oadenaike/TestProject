CREATE VIEW [Access.ManyWho].[RFPEventsReadOnlyVw]
AS 
SELECT              re.RFPEventId                      ,
                    re.RFPId                           ,
                    rr.RFPName                         ,
                    re.EventTypeId                     ,
					et.RFPEventType						,
                    re.SubmittedByPersonId             ,
                    re.ReviewedById                    ,
                    p1.PersonsName as SubmittedBy      , -- IanMc 5/4/16 DAP-372
                    p2.PersonsName as ReviewedByName   , -- IanMc 5/4/16 DAP-372
                    re.EventDetails                    ,
                    re.EventDate                       ,
                    re.ReviewComments                  ,
                    re.EventTrueFalse                  ,
                    re.DepartmentId                    ,
                    d.DepartmentName                   ,
                    re.JiraSubTaskKey                  ,
                    re.DocumentationFolderLink         ,
                    re.JoinGUID                        ,
                    re.RFPEventCreationDate            ,
                    re.RFPEventLastModifiedDatetime
FROM                [Sales].[RFPEvents]                 re 
INNER JOIN          [Sales].[RFPRegister]               rr        ON rr.RFPId                = re.RFPId
INNER JOIN			[Sales].[RFPEventTypes]				et			ON re.EventTypeId = et.RFPEventTypeId
LEFT OUTER JOIN     [Core].[Persons]                    p1        ON re.SubmittedByPersonId  = p1.PersonId -- IanMc 5/4/16 DAP-372
LEFT OUTER JOIN     [Core].[Persons]                    p2        ON re.ReviewedById         = p2.PersonId -- IanMc 5/4/16 DAP-372
LEFT OUTER JOIN     [Core].[Departments]                d         ON re.DepartmentId         = d.DepartmentId
;
