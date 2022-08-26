#Write a query to provide the date for nth occurrence of sunday in future from given date.

declare @today_date date;
declare @n int; 
set @today_date = '2022-08-26';
set @n = 3;


select @today_date - Interval (WEEKDAY(@today_date)+1) day + INTERVAL @n WEEK;
