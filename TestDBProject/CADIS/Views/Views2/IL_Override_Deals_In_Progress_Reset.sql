﻿CREATE VIEW "CADIS"."IL_Override_Deals_In_Progress_Reset" AS 
SELECT V."ASSET" AS "Asset",V."ASSET_NAME" AS "Asset Name",V."I/A" AS "I/A",V."SUB_FUND" AS "Sub Fund",V."SUB_FUND_NAME" AS "Sub Fund Name",V."DEALING_PERIOD_ID" AS "Dealing Period ID",V."ORDER_DATE" AS "Order Date",V."ORDER_REF" AS "Order Ref",V."MAIN_OWNER" AS "Main Owner",V."MAIN_OWNER_NAME" AS "Main Owner Name",V."TYPE" AS "Type",V."STATUS" AS "Status",V."DEAL_CLASS" AS "Deal Class",V."UNITS/SHARES" AS "Units/Shares",V."CCY" AS "Currency",V."VALUE" AS "Value",V."PLAN_ID" AS "Plan ID",V."DESIGNATION" AS "Designation",V."PRODUCT_NAME" AS "Product Name",V."DESCRIPTION" AS "Description",V."AGENT" AS "Agent",V."AGENT_NAME" AS "Agent Name",V."ADMIN_FEE_%" AS "Admin Fee %",V."CREATION_PLUS_%" AS "Creation Plus %",V."INITIAL_CHARGE_%" AS "Initial Charge %",V."FEE_DISCOUNT_%" AS "Fee DIscount %",V."PRICE_DISCOUNT_%" AS "Price Discount %",V."COMMISSION_%" AS "Commission %",V."COMMISSION_VALUE" AS "Commission Value",V."COMMISSION_WAIVER_%" AS "Commission Waiver %",V."RENEWAL_COMMISSION_%" AS "Renewal Commission %",V."PRICE_TYPE" AS "Price Type",V."VALUATION_POINT" AS "Valuation Point",V."PRICING_DEALING_PERIOD_ID" AS "Pricing Dealing Period ID",V."DEAL_TYPE" AS "Deal Type",V."CONTRACT_NOTE_COMMENTS" AS "Contract Note Comments",V."FX_REQD?" AS "FX Reqd?",V."FX_CONFIRMED?" AS "FX Confirmed?",V."FX_INSTRUCTION" AS "FX Instruction",V."INDICATIVE_FX_RATE" AS "Indicative FX Rate",V."CONFIRMED/SPOT_RATE" AS "Confirmed/Spot Rate",V."SETTLEMENT_CCY" AS "Settlement Currency",V."SETTLEMENT_AMT" AS "Settlement Amount",V."DL_%" AS "DL %",V."DL_AMOUNT" AS "DL Amount",V."EXEMPT?" AS "Exempt?",V."ESTIMATED?" AS "Estimated?",V."EXTERNAL?" AS "External?",V."IN_SPECIE" AS "In Specie",V."US_WITHHOLDING_TAX" AS "US Withholding Tax",V."QUOTED_PRICE" AS "Quoted Price",V."DEAL_PRICE" AS "Deal Price",V."PRICE_ADJUSTMENT" AS "Price Adjustment",V."%_OF_FUND_VALUE" AS "% of Fund Value",V."COUNT" AS "Count",V."DEALING_PERIOD_CLOSE_DATE" AS "Dealing Period Close Date",V."DEALING_PERIOD_CUT_OFF_DATE" AS "Dealing Period Cut Off Date",V."CUT_OFF_OVERRIDDEN" AS "Cut Off Overridden",V."EXTERNAL_SOURCE" AS "External Source",V."CADIS_SYSTEM_INSERTED" AS "System Inserted",V."CADIS_SYSTEM_UPDATED" AS "System Updated",V."CADIS_SYSTEM_CHANGEDBY" AS "System Changed By",V."CADIS_SYSTEM_PRIORITY" AS "System Priority",V."CADIS_SYSTEM_LASTMODIFIED" AS "System Last Modified",V."CADIS_SYSTEM_TIMESTAMP" FROM "dbo"."T_OVERRIDE_DEALS_IN_PROGRESS_RESET" V
