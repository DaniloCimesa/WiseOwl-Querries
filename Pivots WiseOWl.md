

Excercise link: https://www.wiseowl.co.uk/sql/exercises/standard/pivots/4169/

Code:
```
use DoctorWho

with Source as (
--CTE table to be the source.
select DoctorName, left(EpisodeType, charindex(' ', EpisodeType)) as EpisodeType, EpisodeId
from tblEpisode E
join tblDoctor D
on E.DoctorId=D.DoctorId
)

--Pivot the count of episode of the source.
select *
from Source
pivot (count(EpisodeId) for episodeType in ([Normal], [Christmas], [50th], [Autumn], [Easter])) as pivottable
```
--------------------------------------------------------------------------------------------------------------

