
-- Ian Mc 5/4/16 DAP-368

CREATE VIEW [Access.ManyWho].[CorporateActionsEventTypesVw] AS
SELECT      [CorporateActionsEventTypeId],
            [CorporateActionsEventTypeName]
FROM        [Operation].[CorporateActionsEventTypes];
