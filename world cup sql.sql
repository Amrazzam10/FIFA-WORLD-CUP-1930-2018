use [World cups]
--1-the total goals scored across all World Cup tournaments
SELECT SUM([Goals Scored]) AS TotalGoals
FROM world_cups;
--2-the average number of goals scored per match in each World Cup:
SELECT Year, ([Goals Scored]/[Matches Played]) AS AvgGoalsPerMatch
FROM world_cups
order by AvgGoalsPerMatch desc
--3-the average number of goals per match:
SELECT AVG([Home Goals] + [Away Goals]) AS AverageGoals
FROM world_cup_matches;
--4-matches where the score was a draw
select COUNT (*) as countofdraw
from world_cup_matches
where [Home Goals]=[Away Goals]
--5-The 10 most goals scored matches
SELECT top 10 [Home Team],[Away Team],year, ([Home Goals] + [Away Goals])  as TotalGoals
FROM world_cup_matches
order by TotalGoals desc
--6- Identify matches with Golden goal
SELECT *
FROM world_cup_matches
WHERE [Win Conditions] LIKE '%Golden goal%';

--7-matches that had no goals (0-0 draw):
SELECT COUNT(*) AS NoGoalsCount
FROM world_cup_matches
where [Home Goals]=0 and [Away Goals]=0
--8-The most countries that have won the worldcup
select winner COUNTRY, count (Winner) as world_cup_winner
from world_cups
group by Winner
order by world_cup_winner desc
--9-Most countries achieved runner-up status
select [Runners-Up] AS COUNTRY, COUNT( [Runners-Up]) as worldcuprunnerup
from world_cups
group by [Runners-Up]
order by worldcuprunnerup desc
--10-Which Countries Hosted the World Cup and Won?
select Year ,[Host Country],Winner
from [world_cups]
where Winner = [Host Country]
--11-which world cup has highest goals scored?
select Year, [Goals Scored]
from world_cups
where [Goals Scored]= (select MAX([Goals Scored]) from world_cups) 
--12-which Final match has a highest goals scored?
select top(1) [Home Team],[Away Team], Year,[Home Goals]+[Away Goals] as goals
from world_cup_matches
where Stage='Final' or Stage = 'Final Round'
order by Goals desc
--13-The stage in which he scored the most goals
select Stage, count ([Goals Scored]) as mostgoalsinstatge
from world_cup_matches wm
join world_cups w
on w.Year=wm.Year
group by Stage
order by mostgoalsinstatge desc
--14-List matches with Extra time
SELECT w.Year, m.[Home Team],[Away Team]
FROM world_cups w
INNER JOIN world_cup_matches m ON w.Year = m.Year
WHERE m.[Win Conditions] LIKE '%Extra time%';
--15- most extra time played by year
SELECT w.Year,COUNT(m.Stage) AS StageCount
FROM world_cups w
INNER JOIN world_cup_matches m ON w.Year = m.Year
WHERE m.[Win Conditions] LIKE '%Extra time%'
GROUP BY  w.Year
order by StageCount desc
--16- top 5 Countries played in world cup
SELECT top 5 Team, SUM(MatchesPlayed) AS TotalMatchesPlayed
FROM (SELECT [Home Team] AS Team,COUNT(*) AS MatchesPlayed FROM world_cup_matches
GROUP BY [Home Team]
UNION ALL
SELECT[Away Team] AS Team, COUNT(*) AS MatchesPlayed
FROM world_cup_matches
GROUP BY [Away Team]
) AS TeamMatches
GROUP BY Team
ORDER BY TotalMatchesPlayed DESC
 

