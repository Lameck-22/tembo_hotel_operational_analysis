create schema tembo;

set search_path to tembo;

select count(*) from tembo.tembo_hotel_dirty;

-- CREATING WORKING TABLE

create table tembo.tembo_hotel
as 
select * from tembo.tembo_hotel_dirty;

select count(*) from tembo.tembo_hotel;

-- Exploring
select * from tembo.tembo_hotel;

-- booking_id
select distinct(booking_id) from tembo.tembo_hotel;

-- guest_name
select distinct guest_name from tembo.tembo_hotel;

select trim(initcap(guest_name)) from tembo.tembo_hotel;

update tembo.tembo_hotel
set guest_name = trim(initcap(guest_name))
where guest_name <> trim(initcap(guest_name));

-- guest_phone
select distinct(guest_phone) from tembo.tembo_hotel

select replace(guest_phone,'+254', '0') from tembo.tembo_hotel;

update tembo.tembo_hotel
set guest_phone = replace(guest_phone,'+254', '0');

-- guest_city
select distinct(guest_city) from tembo.tembo_hotel;

select trim(initcap(guest_city)) from tembo.tembo_hotel;

update tembo.tembo_hotel
set guest_city = trim(initcap(guest_city))
where guest_city <> trim(initcap(guest_city));

update tembo.tembo_hotel
set guest_city = 'Thika'
where guest_city = 'Thikax';

update tembo.tembo_hotel
set guest_city = 'Not Given'
where guest_city = '';


-- guest_nationality
select distinct(guest_nationality) from tembo.tembo_hotel;

-- room_no
select distinct(room_no) from tembo.tembo_hotel;

-- room_type
select distinct(room_type) from tembo.tembo_hotel;

update tembo.tembo_hotel
set room_type = trim(initcap(room_type))
where room_type <> trim(initcap(room_type));

update tembo.tembo_hotel
set room_type = 'Standard'
where room_type = 'Std'; 


-- room_rate_per_night
select distinct(room_rate_per_night) from tembo.tembo_hotel;

-- check_in_date/ Not done
select distinct(check_in_date) from tembo.tembo_hotel;

-- Fix DD/MM/YYYY
UPDATE tembo.tembo_hotel
SET check_in_date = TO_DATE(check_in_date,'DD/MM/YYYY')::TEXT
WHERE check_in_date LIKE '%/%';

-- Fix DD-MM-YY (length = 8)
UPDATE tembo.tembo_hotel
SET check_in_date = TO_DATE(check_in_date,'DD-MM-YY')::TEXT
WHERE check_in_date LIKE '%-%' AND LENGTH(check_in_date) = 8;

-- Fix MM-DD-YYYY (length=10, day part > 12 confirms it's MM-DD not DD-MM)
UPDATE tembo.tembo_hotel
SET check_in_date = TO_DATE(check_in_date,'MM-DD-YYYY')::TEXT
WHERE check_in_date LIKE '%-%'
  AND LENGTH(check_in_date) = 10
  AND SPLIT_PART(check_in_date,'-',2)::INTEGER > 12;

select distinct(check_in_date) from tembo.tembo_hotel;

UPDATE tembo.tembo_hotel
SET check_in_date = '2024-06-06'
WHERE check_in_date = '06-06-2024';

-- check_out_date
-- Fix DD/MM/YYYY
UPDATE tembo.tembo_hotel
SET check_out_date = TO_DATE(check_out_date,'DD/MM/YYYY')::TEXT
WHERE check_out_date LIKE '%/%';

-- Fix DD-MM-YY (length = 8)
UPDATE tembo.tembo_hotel
SET check_out_date = TO_DATE(check_out_date,'DD-MM-YY')::TEXT
WHERE check_out_date LIKE '%-%' AND LENGTH(check_out_date) = 8;

-- Fix MM-DD-YYYY (length=10, day part > 12 confirms it's MM-DD not DD-MM)
UPDATE tembo.tembo_hotel
SET check_out_date = TO_DATE(check_out_date,'MM-DD-YYYY')::TEXT
WHERE check_out_date LIKE '%-%'
  AND LENGTH(check_out_date) = 10
  AND SPLIT_PART(check_out_date,'-',2)::INTEGER > 12;

select distinct(check_out_date) from tembo.tembo_hotel;

UPDATE tembo.tembo_hotel
SET check_out_date = '2024-10-04'
WHERE check_out_date = '04-10-2024';

-- nights_stayed
select distinct(nights_stayed) from tembo.tembo_hotel;

-- staff_name
select distinct(staff_name) from tembo.tembo_hotel;

-- staff_department
select distinct(staff_department) from tembo.tembo_hotel;

-- staff_salary
select distinct(staff_salary) from tembo.tembo_hotel;

update tembo.tembo_hotel
set staff_salary ='NULL'
where staff_salary = 'Not Given';

-- payment_method
select distinct(payment_method) from tembo.tembo_hotel;

update tembo.tembo_hotel
set payment_method = 'M-Pesa'
where payment_method = 'mpesa';

-- booking_status
select distinct(booking_status) from tembo.tembo_hotel;

update tembo.tembo_hotel
set booking_status = initcap(trim(booking_status));

-- total_amount
select distinct(total_amount) from tembo.tembo_hotel;

update tembo.tembo_hotel
set total_amount = trim(replace(total_amount, 'KES',''));

update tembo.tembo_hotel
set total_amount = 'NULL'
where total_amount = '';

-- service_used
select distinct(service_used) from tembo.tembo_hotel;

update tembo.tembo_hotel
set service_used = 'Not Given'
where service_used = '';

-- service_price
select distinct(service_price) from tembo.tembo_hotel;

-- guest_rating
select distinct(guest_rating) from tembo.tembo_hotel;

-- EXPLORING AFTER CLEANING
 select * from tembo.tembo_hotel;

-- Changing datatypes
ALTER TABLE tembo.tembo_hotel
ALTER COLUMN check_in_date TYPE DATE
USING TO_DATE(check_in_date, 'YYYY/MM/DD');

ALTER TABLE tembo.tembo_hotel
ALTER COLUMN check_out_date TYPE DATE
USING TO_DATE(check_out_date, 'YYYY/MM/DD');

-- staff salary data type
UPDATE tembo.tembo_hotel
SET staff_salary = NULL
WHERE TRIM(staff_salary) = 'NULL';

ALTER TABLE tembo.tembo_hotel
ALTER COLUMN staff_salary TYPE INTEGER
USING staff_salary::INTEGER;

-- total_amount
UPDATE tembo.tembo_hotel
SET total_amount = NULL
WHERE TRIM(total_amount) = 'NULL';

UPDATE tembo.tembo_hotel
SET total_amount = REPLACE(total_amount, ',', '');

ALTER TABLE tembo.tembo_hotel
ALTER COLUMN total_amount TYPE INTEGER
USING total_amount::INTEGER;

--===============REVENUE ANALYSIS========================
-- 1.	Revenue analysis: Total revenue by month, by room type, by payment method
SELECT 
    TO_CHAR(check_in_date, 'Month') AS month_name,
    SUM(total_amount) AS monthly_revenue
FROM tembo.tembo_hotel
GROUP BY TO_CHAR(check_in_date, 'Month'), EXTRACT(MONTH FROM check_in_date)
ORDER BY monthly_revenue desc;

select sum(total_amount) as revenue from tembo.tembo_hotel;

-- revenue by room
select room_type, sum(total_amount) as revenue
from tembo.tembo_hotel
group by room_type order by revenue desc;

-- revenue by payment method
select payment_method, sum(total_amount) as revenue
from tembo.tembo_hotel
group by payment_method order by revenue desc;

--===============OCCUPANCY==================================
-- 2.	Occupancy: Which room types are booked most? Average nights stayed per room type

select room_type, count(booking_id) as bookings
from tembo.tembo_hotel
group by room_type order by bookings desc;

-- average nights stayed
select room_type, ROUND(AVG(nights_stayed)) as avg_nights
from tembo.tembo_hotel
group by room_type order by avg_nights desc;

--============GUEST INSIGHTS==============================
-- 3.	Guest insights: Top 10 cities guests come from. Average rating per room type
select guest_city, count(guest_name) as no_of_guest
from tembo.tembo_hotel
group by guest_city
order by no_of_guest desc 
limit 10;

--- average rating per room type
select room_type, ROUND(AVG(guest_rating)) as avg_ratings
from tembo.tembo_hotel
group by room_type order by avg_ratings desc;

--===============STAFF PERFORMANCE============================
--4.	Staff performance: Which staff handled the most bookings? Which department generates most revenue?
select staff_name, count(booking_id) as bookings
from tembo.tembo_hotel
group by staff_name
order by bookings desc;

-- departmental income
select staff_department, sum(total_amount) as income
from tembo.tembo_hotel
group by staff_department
order by income desc;

--==================TRENDS=======================================
-- 5.	Trends: Revenue growth month over month (window function). Busiest vs quietest months
-- revenue growth month over month
with revenue_month as
(select EXTRACT(MONTH FROM check_in_date) AS month_num,TO_CHAR(check_in_date, 'Month') AS month_name, sum(total_amount) as revenue
from tembo.tembo_hotel
group by month_name, month_num
order by month_num),
rev_month as(select *,
       lag(revenue) over(order by month_num) as prev_month_revenue
from revenue_month),
final_rev_month as
(select *, (((revenue - prev_month_revenue) * 100/ prev_month_revenue) ) AS growth_percentage
FROM rev_month)
select * from final_rev_month;



-- busiest vs quiestest months
select EXTRACT(MONTH FROM check_in_date) AS month_num,
       TO_CHAR(check_in_date, 'Month') AS month_name, 
       count(booking_id) as bookings
from tembo.tembo_hotel
group by 1,2
order by bookings desc;



--=================CANCELLATIONS===========================
-- 6.	Cancellations: Cancellation rate per room type. Revenue lost from cancellations and no-shows
-- cancellations per room
select distinct room_type,
   sum(case 
	   when booking_status = 'Cancelled' then 1
	   else 0	
end) as cancellations
from tembo.tembo_hotel
group by room_type;

-- revenue lost from cancellations and no-show
with revenue_sum as 
(select distinct 
   (case 
	   when booking_status = 'Cancelled' then sum(total_amount)
	   when booking_status = 'No Show' then sum(total_amount)
	   --when booking_status = null then
	   else 0	
end )as lost_revenue
from tembo.tembo_hotel
group by room_type, booking_status)
select sum(lost_revenue) as revenue_lost from revenue_sum;

select sum(total_amount) as rev
from tembo.tembo_hotel
where booking_status in ('Cancelled','No Show');


select guest_name, count(booking_id) as bookings from tembo.tembo_hotel
group by guest_name
order by bookings desc;
