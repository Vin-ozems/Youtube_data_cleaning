# Youtube_data_cleaning

## Project Overview
This project is a data cleaning and transformation exercise on a dataset of the top 200 YouTube channels. The goal is to take a raw, inconsistently formatted dataset and turn it into a clean, standardized, duplicate-free table ready for analysis.

## Dataset Description
**top_200_youtubers** — a dataset covering the top 200 YouTube channels, including:
- Channel identity: Channel Name, Username, Country, Youtube Link
- Performance metrics: Followers, Likes, Views, Comments Avg, Boost Index, Engagement Rate (overall and 60-day)
- Rolling average views: 1, 3, 7, 14, 30, and 60-day averages
- Content classification: Main Video Category, Main Topic, More Topics

## Cleaning & Transformation Steps

**1. Column Renaming**
Standardized all column names from inconsistent formats with spaces and periods (e.g. `Channel Name`, `Views Avg.`, `Avg. 7 Day`) into clean, SQL-friendly snake_case names (e.g. `Channel_Name`, `Views_Avg.`, `Avg_7_Day`).

**2. Feature Engineering**
- Reviewed all distinct country codes present in the dataset (10 distinct codes)
- Mapped abbreviated country codes (e.g. `IN`, `KR`, `BR`, `MX`, `SV`, `CL`, `BY`, `RU`, `PH`, `TH`) to full, readable country names (India, South Korea, Brazil, Mexico, El Salvador, Chile, Belarus, Russia, Philippines, Thailand), with all other codes defaulting to "United State"
- Added a new `countries` column to store these standardized, human-readable values

**3. Duplicate Removal**
- Added an auto-incrementing `id` column to uniquely identify each row
- Used `ROW_NUMBER()` partitioned across key identifying fields (channel name, username, followers, likes, boost index, engagement rate, views, comments avg, YouTube link) to detect duplicate records
- Removed all duplicate rows, keeping only the first occurrence per group

**4. Unused Column Removal**
Dropped columns no longer needed after cleaning: `username`, `main_topic`, `Country` (replaced by `countries`), and `Category`

## Recommendation / Tool
The cleaned `top_200_youtubers` table is now ready to plug directly into further analysis or a BI tool (Power BI, Tableau, etc.) for tasks like:
- Ranking channels by engagement rate or views
- Comparing channel performance by country
- Analyzing rolling view averages to spot growth or decline trends

## Tools & Technology
- MySQL
- Window functions (`ROW_NUMBER()`) for duplicate detection
- CASE statements for category standardization

## Notes
- The default "ELSE" value in the country mapping is `'United state'` — worth correcting the capitalization/spelling to `'United States'` for consistency with the other properly formatted country names, and worth double-checking that every non-listed code should genuinely default to the US rather than being mapped explicitly or set to `'Unknown'`.
- The column name `Views_Avg.` retains a trailing period from the rename step, which is unusual for a column name — worth cleaning this to `Views_Avg` for consistency with the other renamed columns.
