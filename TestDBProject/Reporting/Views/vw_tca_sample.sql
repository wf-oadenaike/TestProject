
create view Reporting.vw_tca_sample
as
select  LEFT(C_SECURITY,LEN(C_SECURITY)-3) as JoinColumn, *  from  dbo.T_BBG_TCA_TRADE_ORDERS_AUDIT 
where left(C_SECURITY,1) = '.'
and C_EVENT = 'Activated Order'