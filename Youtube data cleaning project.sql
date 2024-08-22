# DATA CLEANING AND TRANSFORMATION PROJECT
SELECT * 
FROM top_200_youtubers;
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
# RENAMING COLUMNS
ALTER TABLE top_200_youtubers
CHANGE COLUMN `Channel Name` `Channel_Name` TEXT;

ALTER TABLE top_200_youtubers
CHANGE COLUMN `Main Video Category` `Main_Video_Category` TEXT;

ALTER TABLE top_200_youtubers
CHANGE COLUMN `Main topic` `Main_topic` TEXT;

ALTER TABLE top_200_youtubers
CHANGE COLUMN `More topics` `More_topics` TEXT;

ALTER TABLE top_200_youtubers
CHANGE COLUMN `Boost Index` `Boost_Index` TEXT;

ALTER TABLE top_200_youtubers
CHANGE COLUMN `Engagement Rate` `Engagement_Rate` TEXT;

ALTER TABLE top_200_youtubers
CHANGE COLUMN `Engagement Rate 60days` `Engagement_Rate_60days` TEXT;

ALTER TABLE top_200_youtubers
CHANGE COLUMN `Views Avg.` `Views_Avg.` TEXT;

ALTER TABLE top_200_youtubers
CHANGE COLUMN `Avg. 1 Day` `Avg_1_Day` TEXT;

ALTER TABLE top_200_youtubers
CHANGE COLUMN `Avg. 3 Day` `Avg_3_Day` TEXT;

ALTER TABLE top_200_youtubers
CHANGE COLUMN `Avg. 7 Day` `Avg_7_Day` TEXT;

ALTER TABLE top_200_youtubers
CHANGE COLUMN `Avg. 14 Day` `Avg_14_Day` TEXT;

ALTER TABLE top_200_youtubers
CHANGE COLUMN `Avg. 30 day` `Avg_30_day` TEXT;

ALTER TABLE top_200_youtubers
CHANGE COLUMN `Avg. 60 day` `Avg_60_day` TEXT;

ALTER TABLE top_200_youtubers
CHANGE COLUMN `Comments Avg` `Comments_Avg` TEXT;

ALTER TABLE top_200_youtubers
CHANGE COLUMN `Youtube Link` `Youtube_Link` TEXT;

ALTER TABLE top_200_youtubers
CHANGE COLUMN `More_topics` `topics` TEXT;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- FEATURE ENGINEERING
SELECT DISTINCT(country)
FROM top_200_youtubers;

SELECT count(DISTINCT(country))
FROM top_200_youtubers;

SELECT Country, 
    CASE 
        WHEN country = 'IN' THEN 'India'
        WHEN country = 'KR' THEN 'South Korea'
        WHEN country = 'BR' THEN 'Brazil'
        WHEN country = 'MX' THEN 'Mexico'
        WHEN country = 'SV' THEN 'El Salvador'
        WHEN country = 'CL' THEN 'Chile'
        WHEN country = 'BY' THEN 'Belarus'
        WHEN country = 'RU' THEN 'Russia'
        WHEN country = 'PH' THEN 'Philippines'
        WHEN country = 'TH' THEN 'Thailand'
        ELSE 'United state'
    END AS Countries
FROM top_200_youtubers;

ALTER TABLE top_200_youtubers
ADD COLUMN countries VARCHAR(20);

UPDATE top_200_youtubers
SET countries = (CASE 
                     WHEN country = 'IN' THEN 'India'
                     WHEN country = 'KR' THEN 'South Korea'
                     WHEN country = 'BR' THEN 'Brazil'
                     WHEN country = 'MX' THEN 'Mexico'
					 WHEN country = 'SV' THEN 'El Salvador'
					 WHEN country = 'CL' THEN 'Chile'
                     WHEN country = 'BY' THEN 'Belarus'
                     WHEN country = 'RU' THEN 'Russia'
                     WHEN country = 'PH' THEN 'Philippines'
					 WHEN country = 'TH' THEN 'Thailand'
                     ELSE 'United state'
                     END);
-- -----------------------------------------------------------------------------------------------------------------------------------------------
# REMOVING DUPLICATE
ALTER table top_200_youtubers
ADD COLUMN id INT PRIMARY KEY AUTO_INCREMENT;

WITH row_numb AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY channel_name,
                            username,
                            followers,
                            likes,
                            boost_index,
                            engagement_rate,
                            views,
                            comments_avg,
                            youtube_link
               ORDER BY id
           ) AS row_numb
    FROM top_200_youtubers
)
SELECT *
FROM row_numb
WHERE row_numb > 1;

WITH row_numb AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY channel_name,
                            username,
                            followers,
                            likes,
                            boost_index,
                            engagement_rate,
                            views,
                            comments_avg,
                            youtube_link
               ORDER BY id
           ) AS row_numb
    FROM top_200_youtubers
)
DELETE t
FROM top_200_youtubers t
JOIN row_numb r ON t.id = r.id
WHERE r.row_numb > 1;
-- ------------------------------------------------------------------------------------------------------------------------------------------------
# DELETING UNUSED COLUMNS
SELECT *
FROM top_200_youtubers;

ALTER TABLE top_200_youtubers
DROP COLUMN username, 
DROP COLUMN main_topic,
DROP COLUMN Country,
DROP COLUMN Category;




						