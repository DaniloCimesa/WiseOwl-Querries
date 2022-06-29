```

Excercise link: https://www.wiseowl.co.uk/sql/exercises/standard/parameters-and-return-values/4200/

Code: 
--Creating procedure where you create a variable which contains letter you want to find in a CountryName. 
--By deleting the first or second wildcard sign you can change whetner you want the CountryName to end or start with the input letter.

Create Proc CountriesProcedure
(@Letter char(1))
as
begin

select EventName, EventDate, CountryName
from tblEvent E
join tblCountry C
on E.CountryID=C.CountryID
Where CountryName like '%'+@Letter+'%'
end

exec CountriesProcedure S
--For example I used a input letter S.
-------------------------------------------------------------------------------------------------------------------------------------------

Excercise link: https://www.wiseowl.co.uk/sql/exercises/standard/parameters-and-return-values/4211/

Code:

use WorldEvents

alter procedure uspContinentEvents 

(@ContinentName varchar(20),
@StartDate varchar(10),
@EndDate varchar(10))

as
begin
Select ContinentName, EventName, EventDate
from tblEvent E
join tblCountry C
on E.CountryID=C.CountryID
join tblContinent Co
on C.ContinentID=Co.ContinentID
where ContinentName like '%'+@ContinentName+'%' and EventDate between @StartDate and @EndDate

end

exec uspContinentEvents Asia, '1990-01-01', '2000-01-01'
--For example input data I used is continent Asia and dates between January 1st 1990 and January 1st 2000.
--------------------------------------------------------------------------------------------------------------------------------------
Excercise link: https://www.wiseowl.co.uk/sql/exercises/standard/dynamic-sql/1804/


Code:
--Creating a procedure where input parameters are stored in a variable which is executed at the end.
use Training

alter Proc spSelect 
(@Columns varchar(100),
@TableName varchar(50),
@NumberRows int,
@OrderColumn varchar (50)
)
as
declare @Variable varchar(max)=

'Select Top ' +convert(varchar(5),@NumberRows)+' '+ @Columns+
' from '+@TableName+
' order by '+@OrderColumn

exec (@Variable)

exec spSelect 'FirstName, LastName', 'tblPerson', 5, 'LastName'
-----------------------------------------------------------------------------------------------------------------------------------------
Excercise link: https://www.wiseowl.co.uk/sql/exercises/standard/archived/1264/

Code:

--Procedure which returns Events whose input start letter and end letter is given. End letter can be left out.
ALTER procedure spEvents
(@StartLetter char(1),
@EndLetter char(1)='')
as
begin 

select EventName as [Name of Event], convert (varchar(30),EventDate,101) as [Date of Event]
from tblEvent
where Left(EventName,1)=@StartLetter AND
@EndLetter=case
			when @EndLetter='' THEN @EndLetter
			else Right(EventName,1)
			end
end
--In where clause using the case with @EndLetter variable to case if the end letter is given then it should be the one 
--in the end and if it is not given then do nothing.
------------------------------------------------------------------------------------------------------------------------------------
Excercise Link: https://www.wiseowl.co.uk/sql/exercises/standard/archived/1779/

Code:
use Training

Create Proc SpListDelegates 
(@CompanyName varchar(30)=Null,
 @CourseName varchar(30)=Null)
 as
begin
select OrgName as 'Company Name', CourseName as 'Course Name'
from tblPerson P
join tblOrg O
on P.OrgId=O.OrgId
join tblDelegate D
on P.Personid=D.PersonId
join tblSchedule S
on S.ScheduleId=D.ScheduleId
join tblCourse C
on C.CourseId=S.CourseId
where (@CompanyName is null or OrgName=@CompanyName) and (@CourseName is null or CourseName like '%'+@CourseName+'%')
end
------------------------------------------------------------------------------------------------------------------------------------------
Excercise link: https://www.wiseowl.co.uk/sql/exercises/standard/parameters-and-return-values/3974/


code: use doctorwho
--Excercise made just to practice how to return variables from procedure. This assignment could be done in a more easier way but okay.
alter Proc spGoodandBad
(@SeriesNumber int,
 @NumEnemies int output,
 @NumCompanions int output)
as
begin

Declare @companions int = (
select  Count(distinct(CompanionName))
from tblEpisode E
join tblEpisodeCompanion Ec
on E.EpisodeId=Ec.EpisodeId
join tblCompanion C
on Ec.CompanionId=C.CompanionId
where SeriesNumber=@SeriesNumber
group by SeriesNumber)

declare @enemies int = (

select count(distinct(En.EnemyId))
from tblEpisode E
join tblEpisodeEnemy Ee
on E.EpisodeId=Ee.EpisodeId
join tblEnemy En
on Ee.EnemyId=En.EnemyId
where SeriesNumber=@SeriesNumber
group by SeriesNumber
)
Set @NumEnemies=@enemies
set @NumCompanions=@companions

end

declare @SeriesNumber int=3
declare @NumEnemies int
declare @NumCompanions int

exec spGoodandBad @SeriesNumber, @NumEnemies output, @NumCompanions output

Select @SeriesNumber as SeriesNum, @NumEnemies as Enemies, @NumCompanions as Companions
--------------------------------------------------------------------------------------------------------------------
Excercise link: https://www.wiseowl.co.uk/sql/exercises/standard/parameters-and-return-values/4220/

Code: 

use WorldEvents
--Create a procedure where you output parameters. Then create a querry you want.
alter Proc SpCountryNumers
(@InputCountry varchar(50)=Null output,
@EventCount int=null output)
as

begin

select top 1 @InputCountry=countryName, @EventCount = count(E.CountryID)
from tblEvent E
join tblCountry C
on E.CountryID=C.CountryID
group by CountryName
order by count(E.CountryID) desc

end
--After you run the procedure. Create variables which will contain output parameters from procedure.
Declare @CountryVariable varchar(250)
Declare @EventVariable int
--Execute the procedure and write an equation where a variable will be equal to corresponding output parameter.
exec spCountryNumers 
@InputCountry = @CountryVariable output,
@EventCount = @EventVariable output
--Run the recently declared variables in select statement to show them.
select @CountryVariable as Country, @EventVariable as [Number of Events]
--------------------------------------------------------------------------------------------------------------------
Excercise link: https://www.wiseowl.co.uk/sql/exercises/standard/dynamic-sql/3992/


Code:
use DoctorWho
--Procedure where you have a variable within the procedure.
alter proc spEpisodesSorted
(@SortColumn varchar(30)= 'EpisodeId',
@SortOrder varchar(10)= 'ASC')

as
declare @Sql varchar(max)=
'
Select *
from tblEpisode
order by ' + @SortColumn +' ' + @SortOrder

exec (@sql)

spEpisodesSorted 'Title', 'Desc'
-------------------------------------------------------------------------------------
Excercise link: https://www.wiseowl.co.uk/sql/exercises/standard/parameters-and-return-values/4223/

Code:
use WorldEvents
--Create first procedure which will give us the output parameter.
Alter Proc TimeOfWoe
(@FirstContinent varchar(100)=null output)
as

select top 1 @FirstContinent=ContinentName
from tblEvent E
join tblCountry C
on E.CountryID=C.CountryID
join tblContinent Co
on C.ContinentID=Co.ContinentID
order by EventDate asc


--Second procedure will use the parameter from procedure 1.
Create Proc TimeOfWoe2
(@ContinentName varchar(100))
as

select EventName, EventDate, ContinentName
from tblEvent E
join tblCountry C
on E.CountryID=C.CountryID
join tblContinent Co
on C.ContinentID=Co.ContinentID
where ContinentName=@ContinentName

--Here we have to declare the second variable which will contain the variable from the first procedure and output it for the second one.
declare @Var1 varchar(100)=''
exec TimeOfWoe @FirstContinent=@Var1 output
exec TimeOfWoe2 @ContinentName=@Var1
---------------------------------------------------------------------------------------------------

--Excercise link: https://www.wiseowl.co.uk/sql/exercises/standard/archived/2365/

--Adding to DB from a procedure.

Code:
use HistoricalEvents

create procedure spAddEvent 
(@EventName varchar(20), @Eventdate datetime, @Description varchar(max), @CountryId smallint) 

as
begin 
insert into tblEvent(
EventName,
EventDate, 
Description,
CountryId)
values (
@EventName,
@EventDate,
@Description,
@CountryId)
end

exec spAddEvent 'Spain win World Cup', '07/11/2010', 'Spain defeat the Netherlands in overtime', 14

select *
from tblEvent
order by EventDate desc
```
