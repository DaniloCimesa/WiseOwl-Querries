Excercise link: https://www.wiseowl.co.uk/sql/exercises/standard/archived/1107/


Code:

select case
when eventdate<'1950-01-01' then 'Decade 1- forties'
when eventdate<'1960-01-01' then 'Decade 2 - fifties'
when eventdate<'1970-01-01' then 'Decade 3 - sixties'
when eventdate<'1980-01-01' then 'Decade 4 - seventies'
when eventdate<'1990-01-01' then 'Decade 5 - eighties'
when eventdate<'2000-01-01' then 'Decade 6 - ninties'
else 'Decade 7 - noughties'
end as Decade, count(*) as [Number of Events]
from tblEvent
group by 
case
when eventdate<'1950-01-01' then 'Decade 1- forties'
when eventdate<'1960-01-01' then 'Decade 2 - fifties'
when eventdate<'1970-01-01' then 'Decade 3 - sixties'
when eventdate<'1980-01-01' then 'Decade 4 - seventies'
when eventdate<'1990-01-01' then 'Decade 5 - eighties'
when eventdate<'2000-01-01' then 'Decade 6 - ninties'
else 'Decade 7 - noughties'
end
-------------------------------------------------------------------------------------
Excercise link: https://www.wiseowl.co.uk/sql/exercises/standard/aggregation-and-grouping/4129/


Code: 

select case when year(eventdate)>=2000 then '21st century'
            when year(eventdate)>=1900 then '20th century'
			when year(eventdate)>=1800 then '19th century'
			when year(eventdate)>=1700 then '18th century'
			else ''
			end as Century, count(eventid) as [Number Events]
from tblEvent
group by 
(case when year(eventdate)>=2000 then '21st century'
            when year(eventdate)>=1900 then '20th century'
			when year(eventdate)>=1800 then '19th century'
			when year(eventdate)>=1700 then '18th century'
			else '' 
			end) with cube
---------------------------------------------------------------------------------------------------      
Excercise link: https://www.wiseowl.co.uk/sql/exercises/standard/archived/1096/

Code: 
--Simple case statement. Nothing fancy.    
use HistoricalEvents

select Eventdate, eventName, CountryId, 
case when CountryId=17 then 'UK'
     when CountryId=18 then 'United States'
	                   else 'Somewhere else'
end as [Type of Event]
from tblEvent
----------------------------------------------------------------------------------------------------
Excercise link: https://www.wiseowl.co.uk/sql/exercises/standard/calculations-using-dates/4119/


Code:
use WorldEvents
--For me personally very fun excercise, where you have to convert a input date to a more prettier version with Day of the Week, ordinal suffix next to number and so on.

select EventName, EventDate, 
--Using datename function to name days of the week and months. after that using datepart to get the number of the day in month. 
--Be careful, datepart returns int value of the strin so you'll have to convert it to varchar(convert or cast).
datename(weekday, eventdate)+' '+convert(varchar(2), datepart(day,eventdate))+
case when datepart(day, eventdate) in (1,21,31) then 'st' --When number of the day in month is either 1, 21 or 31 add st to it.
     when datepart(day, eventdate) in (2,22) then 'nd' --When it is either 2 or 22 then add nd. If it is 3 or 23 then rd, else add th at the end of it.
	 when datepart(day, eventdate) in (3,23) then 'rd'
	 else 'th' end
	 +' '+ datename(month, eventdate)+' ' +convert(varchar(5), year(eventdate)) as FullDate --At the end add the year when event happened, again you have to convert it to varchar but now you know how :).
from tblEvent
-------------------------------------------------------------------------------------


