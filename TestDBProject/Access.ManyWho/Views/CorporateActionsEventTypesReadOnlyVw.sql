
-- Ian Mc 5/4/16 DAP-368

CREATE VIEW [Access.ManyWho].[CorporateActionsEventTypesReadOnlyVw] AS
SELECT      [CorporateActionsEventTypeId],
            [CorporateActionsEventTypeName]
FROM        [Operation].[CorporateActionsEventTypes];
