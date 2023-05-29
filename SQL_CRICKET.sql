#1 Import the csv file to a table in the database.

CREATE DATABASE ICC_TEST;
use icc_test;

select * from  `icc test batting figures`;

#2 Remove the column 'Player Profile' from the table.

ALTER TABLE `icc test batting figures` DROP COLUMN `Player Profile`;

#3 Extract the country name and player names from the given data and store it in separate columns for further usage.

alter table `icc test batting figures` add column Country varchar(255);
alter table `icc test batting figures` add column Player_Name varchar(255);


UPDATE `icc test batting figures` 
SET 
    Country = SUBSTR(Player,
        LENGTH(Player) - LOCATE('(', REVERSE(Player)) + 1,
        LOCATE(')', Player) - LENGTH(Player) + LOCATE('(', REVERSE(Player)) - 1);
UPDATE `icc test batting figures` 
SET 
    Player_Name = SUBSTR(Player,
        1,
        LENGTH(Player) - LOCATE('(', REVERSE(Player)) - 1);

SELECT * FROM `icc test batting figures`;


#4 From the column 'Span' extract the start_year and end_year and store them in separate columns for further usage.

ALTER TABLE `icc test batting figures` ADD COLUMN Start_Year int;
ALTER TABLE  `icc test batting figures` ADD COLUMN End_Year int;

UPDATE `icc test batting figures` 
SET 
    Start_Year = SUBSTR(Span, 1, 4),
    End_Year = SUBSTR(Span, 6, 4);


#5 The column 'HS' has the highest score scored by the player so far in any given match. The column also has details if the player had completed the match in a NOT OUT status. Extract the data and store the highest runs and the NOT OUT status in different columns.

ALTER TABLE `icc test batting figures` ADD COLUMN Highest_Score int;
ALTER TABLE `icc test batting figures` ADD COLUMN NOT_OUT int;

UPDATE `icc test batting figures` 
SET 
    Highest_Score = CASE
        WHEN LOCATE('*', HS) = 0 THEN HS
        ELSE SUBSTR(HS, 1, LOCATE('*', HS) - 1)
    END,
    NOT_OUT = CASE
        WHEN LOCATE('*', HS) = 0 THEN 0
        ELSE 1
    END;
    
#6 Using the data given, considering the players who were active in the year of 2019, create a set of batting order of best 6 players using the selection criteria of those who have a good average score across all matches for India.

select * from `icc test batting figures`;

SELECT 
    Player_name, avg
FROM
    `icc test batting figures`
WHERE
    country = 'india' AND start_year <= 2019
        AND end_year >= 2019
ORDER BY avg DESC
LIMIT 6;


#7 Using the data given, considering the players who were active in the year of 2019, create a set of batting order of best 6 players using the selection criteria of those who have the highest number of 100s across all matches for India.

select * from `icc test batting figures`;
SELECT 
    Player_name, `100` AS Most_Centuries
FROM
    `icc test batting figures`
WHERE
    country LIKE '%india%' AND start_year <= 2019
        AND end_year >= 2019
ORDER BY `100` DESC
LIMIT 6;

#8.	Using the data given, considering the players who were active in the year of 2019, create a set of batting order of best 6 players using 2 selection criteria of your own for India.

# SELECTION CRITERIA 1
SELECT 
    player_name, Runs AS Most_Runs
FROM
    `icc test batting figures`
WHERE
    country = 'india' AND start_year <= 2019
        AND end_year >= 2019
ORDER BY Runs DESC
LIMIT 6;


# SELECTION CRITERIA 2 
SELECT 
    player_name, avg, `100`, `50`
FROM
    `icc test batting figures`
WHERE
    country = 'india' AND start_year <= 2019
        AND end_year >= 2019
ORDER BY avg DESC , `100` DESC , `50` DESC
LIMIT 6;


#9.	Create a View named ‘Batting_Order_GoodAvgScorers_SA’ using the data given, considering the players who were active in the year of 2019, create a set of batting order of best 6 players using the selection criteria of those who have a good average score across all matches for South Africa.

SELECT 
    player_name, avg AS Batting_Order_GoodAvgScorers_SA
FROM
    `icc test batting figures`
WHERE
    country = 'SA' AND start_year <= 2019
        AND end_year >= 2019
ORDER BY avg DESC
LIMIT 6;


#10.	Create a View named ‘Batting_Order_HighestCenturyScorers_SA’ Using the data given, considering the players who were active in the year of 2019, create a set of batting order of best 6 players using the selection criteria of those who have highest number of 100s across all matches for South Africa.

SELECT 
    player_name, `100` AS Batting_Order_HighestCenturyScorers_SA
FROM
    `icc test batting figures`
WHERE
    country = 'SA' AND start_year <= 2019
        AND end_year >= 2019
ORDER BY `100` DESC
LIMIT 6;


#11.	Using the data given, Give the number of player_played for each country.

SELECT 
    country, COUNT(DISTINCT player) AS player_played
FROM
    `icc test batting figures`
GROUP BY country;

#12.	Using the data given, Give the number of player_played for Asian and Non-Asian continent

SELECT 
    CASE
        WHEN
            country IN ('India' , 'Pakistan',
                'Sri Lanka',
                'Bangladesh',
                'Afghanistan')
        THEN
            'Asian'
        ELSE 'Non-Asian'
    END AS continent,
    COUNT(DISTINCT player) AS player_played
FROM
    `icc test batting figures`
GROUP BY continent;