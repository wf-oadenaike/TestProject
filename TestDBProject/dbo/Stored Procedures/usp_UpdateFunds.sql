
CREATE  PROCEDURE dbo.usp_UpdateFunds AS
UPDATE T_BBG_RISK_MONITORING_IN_ALLOCATION 
SET FUND =  CASE WHEN left(right(left(FILENAME,23),8),7)  =  'WIMIFF2' then 'WIMEIF'
				  WHEN left(right(left(filename,23),8),7)  =  'WIMPCT2' then 'WIMPCT'
				  WHEN left(right(left(filename,23),8),7)  =  'OMNIS12' then 'OMNIS'
				  WHEN left(right(left(filename,23),8),7)  =  'OMWEIF2' then 'OMWEIF'
				  WHEN left(right(left(FILENAME,23),8),7)  =  'SJPHIY2' then 'SJPHIY'
				  WHEN left(right(left(filename,23),8),7)  =  'SJPDST2' then 'SJPDST'
				  WHEN left(right(left(filename,23),8),7)  =  'SJPNUK2' then 'SJPNUK'
				  WHEN left(right(left(filename,23),8),7)  =  'SJPXUK2' then 'SJPXUK'
				  WHEN left(right(left(filename,23),8),7) =   'WEST012' THEN 'WEST012'
				  WHEN left(right(left(filename,23),8),7) =   'WIMEIF2' THEN 'WIMEIF'
			 	  else  left(right(left(FILENAME,23),8),7)
		END   
