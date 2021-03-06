--Excercise link: https://www.wiseowl.co.uk/sql/exercises/standard/archived/1882/

--Code: 

Use Movie

with cte_a as
(select FilmName, FilmID 
from tblDirector D
join tblFilm F
on D.DirectorID=F.FilmDirectorID
Where DirectorName ='Steven Spielberg'
)
select ActorName, FilmName, CastCharacterName
from cte_a
join tblCast C
on C.CastFilmID=cte_a.FilmID
join tblActor A
on C.CastActorID=A.ActorID

--Sollution without creating CTE. Simply creating a huge table with couple of joins in a row.

select ActorName, FilmName, CastCharacterName
from tblCast C
join tblActor A
on C.CastActorID=A.ActorID 
join tblFilm F
on C.CastFilmID=F.FilmID
join tblDirector D
on F.FilmDirectorID=D.DirectorID
where DirectorName ='Steven Spielberg'
---------------------------------------------------------------------------------
--Excercise link: https://www.wiseowl.co.uk/sql/exercises/standard/derived-tables-and-ctes/4266/

--Code:

with ManyCountries

as (

select ContinentName, Count(countryName) as CountryCount
from tblCountry C
join tblContinent Co
on C.ContinentID=Co.ContinentID
group by ContinentName
having COUNT(countryname)>3
),

FewEvents as
(
select distinct ContinentName, count(EventName) as EventCount
from tblCountry C
join tblContinent Co
on C.ContinentID=Co.ContinentID
join tblEvent E
on C.CountryID=E.CountryID
group by ContinentName
having count(eventname)<10
)

select FE.ContinentName, CountryCount, EventCount
from ManyCountries MC
join FewEvents FE
on MC.ContinentName=FE.ContinentName
--------------------------------------------------------------------------------------
--Excercise link: https://www.wiseowl.co.uk/sql/exercises/standard/calculations/4114/

--Code:


use WorldEvents
--One way to do it. With creating a common table expression.
with cte_a as
(
select Country, KmSquared, KmSquared/20761 as WalesUnits, KmSquared%20761 as AreaLeftOver
from CountriesByArea
)

select *, case when kmsquared < 20761 then 'Smaller than Wales'
else convert(varchar(4), WalesUnits)+' x Wales plus ' + convert(varchar(10), AreaLeftOver)+ ' sq. km'
end as WalesComparison
from cte_a

--Another way. With declaring a variable which contains area of Wales. Second one is a bit more complicated to read if you ask me. 

Declare @WalesSize int = 20761
select Country, KmSquared, KmSquared/@WalesSize as WalesUnits, KmSquared%@WalesSize as AreaLeftOver, 
case when KmSquared<@WalesSize then 'Smaller than Wales'
else (Cast((KmSquared/@WalesSize) as varchar(4)))+' x Wales plus '+(convert(varchar(10), KmSquared%@WalesSize)) +' sq. km'
end as WalesComparison
from CountriesByArea
-----------------------------------------------------------------------------------------------------------
--Excercise link: https://www.wiseowl.co.uk/sql/exercises/standard/derived-tables-and-ctes/4136/

--Code:


use WorldEvents
--Merging 2 CTE's in one
With TopCountries as(

select top 3 CountryID, count(eventid) as EventCount
from tblEvent
group by CountryID
order by EventCount desc
),

 TopCategories as (select top 3 CategoryID, count(eventid) as CatCount
from tblEvent
group by CategoryID
order by CatCount desc)

select cy.CountryId, cg.CategoryId
from topcountries as cy cross join topcategories as cg 
---------------------------------------------------------------------------------------------------------------------
--Excercise link: https://www.wiseowl.co.uk/sql/exercises/standard/derived-tables-and-ctes/4249/

--Code:

use WorldEvents
--CTE to find CategoryNames for events that occured in Space.
with cte_a as (

Select distinct CountryName, CategoryName, E.CategoryID
from tblEvent E
join tblCountry C
on E.CountryID=C.CountryID
join tblCategory Ca
on E.CategoryID=Ca.CategoryID
where CountryName='Space'
)
--Using the Data from CTE to get the wanted rows.
select distinct CountryName
from tblEvent E
join tblCountry C
on E.CountryID=C.CountryID
where CategoryID in (Select CategoryID from cte_a) and CountryName !='Space'
------------------------------------------------------------------------------------------------------------------
