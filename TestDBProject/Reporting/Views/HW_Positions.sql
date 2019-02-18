
CREATE VIEW  Reporting.HW_Positions

AS

-------------------------------------------------------------------------------------- 
-- Name: Reporting.HW_Positions
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- Olu: 06/02/2019 JIRA: DAP-2516 [Create View to show HW_Positions  ]
--
-- 
-------------------------------------------------------------------------------------- 

SELECT			[edm_sec_id], 
                [file_name], 
                ac.morningstar_asset_class, 
                ac.square_mile_asset_class,
				ac.ASSET_TYPE,
				ac.IMA_SECTOR,
                [file_date], 
                [customer_code], 
                [model_code], 
                [model_date], 
                [model_description], 
                [instrument_uii], 
                [sedol], 
                [currency], 
                [stock_short_name], 
                [sector_code], 
                [uii_allocation_pct], 
                [current_percentage], 
                [change_percentage], 
                [start_price], 
                [start_price_date], 
                [current_price], 
                [current_date] 
FROM   dbo.t_hw_positions hw 
       LEFT JOIN t_ref_fnd_asset_class ac 
               ON HW.sector_code = ac.ima_sector 