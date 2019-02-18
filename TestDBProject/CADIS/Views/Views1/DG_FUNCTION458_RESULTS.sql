﻿CREATE VIEW "CADIS"."DG_FUNCTION458_RESULTS" AS 
SELECT ET."FinancialFactId",ET."FiscalYear",ET."FiscalFirstDayOfYear",ET."FiscalLastDayOfYear",ET."DepartmentNumber",ET."DepartmentName",ET."TransactionDate",ET."Details",ET."Amount",ET."Forecast",ET."TransactionNo",ET."AccountName",ET."AccountCategory",ET."TransactionTypeBK",ET."Supplier",ET."NominalCode",ET."FinancialLineCode",ET."ProjectName",ET."IsDiscretionary",ET."IsNonDiscretionary",ET."AmountRaw",ET."ControlDate",ET."AsAtDate" FROM "Access.WebDev"."ufn_FinancialDashboardAll"(NULL) ET
