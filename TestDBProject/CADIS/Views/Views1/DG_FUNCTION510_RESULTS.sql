﻿CREATE VIEW "CADIS"."DG_FUNCTION510_RESULTS" AS 
SELECT ET."ResearchBrokerPaymentId",ET."ResearchBrokerId",ET."StatusId",ET."QuarterId",ET."QuarterBudget",ET."BrokerLetterSentDate",ET."InvoicedAmount",ET."InvoiceSentDate",ET."PaidAmount",ET."PaymentDate",ET."SubmittedByPersonId",ET."DocumentationFolderLink",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_LASTMODIFIED" FROM "Investment"."ResearchBrokerPaymentRegister" ET WITH (NOLOCK)
