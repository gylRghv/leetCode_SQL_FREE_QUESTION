# Write your MySQL query statement below
with trip_details as (
    select *
    from Trips t
    join Users u
    on t.client_id  = u.users_id
    where lower(u.banned) != 'yes' and t.driver_id in (select distinct users_id from Users where lower(banned) != 'yes') 
    and request_at >= date '2013-10-01' and request_at <= date '2013-10-03'
)
, total_trips as (
    select request_at as t_request, count(status) as trip_count
    from trip_details
    group by request_at
)
, cancelled_trips as (
    select request_at as c_request, count(status) as trip_cancel_count
    from trip_details
    where lower(status) != 'completed'
    group by request_at
)
, result as (
    select t_request as `Day`,  round((ifnull(trip_cancel_count, 0 )/trip_count)*1.0,2) as `Cancellation Rate`
    from total_trips 
    left join cancelled_trips
    on t_request = c_request
)
select * from result;


-- Method-2
SELECT 
request_at as `Day`, 
round(sum(case when status like 'cancelled%' then 1 else 0 end)*1.0/count(status), 2) as 'Cancellation Rate'
FROM Trips
JOIN Users
ON client_id = users_id
WHERE banned = 'No'
AND request_at >= date '2013-10-01' and request_at <= date '2013-10-03'
AND driver_id in (select distinct users_id from Users where role = 'driver' and banned = 'No') 
group by request_at;
