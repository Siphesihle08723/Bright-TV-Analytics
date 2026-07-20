---------------------------------------------------------------------------
 -- Exporotary data Analysis for BrightTV Case study
 -- Working with Demographics dataset
  ---------------------------------------------------------------------------

 
  ---------------------------------------------------------------------------
 -- Understanding the BrightTV Data
  ---------------------------------------------------------------------------
Select*
from `bright_tv`.`default`.`demographics`
limit 10;
 
  ---------------------------------------------------------------------------
 -- Get to known how many rows do we have
  ---------------------------------------------------------------------------
Select distinct count(UserID)
from `bright_tv`.`default`.`demographics`;

Select count(*)
from `bright_tv`.`default`.`demographics`;

  ---------------------------------------------------------------------------
 -- Creating email flag
 -- if user have email then 1 if not then 0
  ---------------------------------------------------------------------------
  Select 
      Case
          when Email is not null or Email <>(' ') or email not in ('None') then '1'
          else 0
      end as email_flag
  from `bright_tv`.`default`.`demographics`;
  
  ---------------------------------------------------------------------------
 -- Creating Social Media Handle flag
 -- if user have Social Media Handle then 1 if not then 0
  ---------------------------------------------------------------------------


   Select 
      Case
          when `Social Media Handle` is not null or `Social Media Handle` <>(' ') or `Social Media Handle` not in ('None') then '1'
          else 0
      end as smh_flag
  from `bright_tv`.`default`.`demographics`;

 
  ---------------------------------------------------------------------------
 -- What type of gender do we have
  ---------------------------------------------------------------------------
Select distinct(Gender)
from `bright_tv`.`default`.`demographics`;
 
  ---------------------------------------------------------------------------
 -- case statemnet
 -- none and empty space grouped to unclassified
  ---------------------------------------------------------------------------
Select distinct
        case
            when Gender in ('None', ' ') then 'Unclassified'
            else Gender
        end as Gender
from `bright_tv`.`default`.`demographics`;
 
  ---------------------------------------------------------------------------
 -- checking null value in the race colomn
  ---------------------------------------------------------------------------
Select Race
from `bright_tv`.`default`.`demographics`
wherE Race is null;
 
  ---------------------------------------------------------------------------
 --What type of race do we have
  ---------------------------------------------------------------------------
Select distinct Race
from `bright_tv`.`default`.`demographics`;
 
  ---------------------------------------------------------------------------
 --Case statement under race
 -- grouped none and empty space to  other
  ---------------------------------------------------------------------------
Select distinct
 case
            when Race in ('None', ' ','other') then 'Other'
            else Race
        end as Race
from `bright_tv`.`default`.`demographics`;
 
  ---------------------------------------------------------------------------
--Get min, max and avg age of the subcribers
  ---------------------------------------------------------------------------
Select min(Age) as min_age,
       max(Age) as max_Age,
       avg(Age) as avg_age
from `bright_tv`.`default`.`demographics`;
 
  ---------------------------------------------------------------------------
 -- Creatig age brackets
 -- 0 to 18 equals to Teenage
 -- 19 to 35 equals to Adult
 -- 36 to 60 equals to Older Adult
 -- 61 to 75 equals to Grand Parents
 -- 76 and abouve equals to Older Grand Parants
  ---------------------------------------------------------------------------
Select distinct
    case
        when Age between 0 and 18 then 'Teenage'
        when Age between 19 and 35 then 'Adult'
        when Age between 36 and 60 then 'Older Adult'
        when Age between 61 and 75 then 'Grand Parents'
        else 'Older Grand Parents'
end as Age_brackects
from `bright_tv`.`default`.`demographics`;

  ---------------------------------------------------------------------------
 --What type of Province do we have
  ---------------------------------------------------------------------------
Select Distinct Province
from `bright_tv`.`default`.`demographics`;

  ---------------------------------------------------------------------------
 --Grouped None and empty space to not Provided
  ---------------------------------------------------------------------------
Select distinct
       case
            when Province in ('None', ' ') then 'Not Provided'
            else Province
        end as Province
from `bright_tv`.`default`.`demographics`;

 ---------------------------------------------------------------------------
 -- Working with bright_tv_vierweship dataset
  ---------------------------------------------------------------------------
 Select*
 from `bright_tv`.`default`.`bright_tv_vierweship`
 limit 100;

  ---------------------------------------------------------------------------
 -- Understanding the BrightTV Data
  ---------------------------------------------------------------------------
 Select*
 from `bright_tv`.`default`.`bright_tv_vierweship`
 limit 100;
 
  ---------------------------------------------------------------------------
 -- Get to known how many rows do we have
  ---------------------------------------------------------------------------

Select distinct count(UserID0) as num_row
from `bright_tv`.`default`.`bright_tv_vierweship`;

Select count(*) as num_rows
from `bright_tv`.`default`.`bright_tv_vierweship`;

  ---------------------------------------------------------------------------
 -- Get to known duplicate channel and null value
  ---------------------------------------------------------------------------
Select distinct Channel2
from `bright_tv`.`default`.`bright_tv_vierweship`
Where Channel2 is null
;
Select distinct Channel2
from `bright_tv`.`default`.`bright_tv_vierweship`;

  ---------------------------------------------------------------------------
 -- Case statement to sort channel
  ---------------------------------------------------------------------------
Select distinct 
     case 
        when Channel2 in ('SuperSport Live Events','Live on SuperSport','Supersport Live Events','DStv Events 1') then 'Live Event'
        when Channel2 in ('Sawsee','SawSee') then 'SawSee'
        when Channel2 = 'E! Entertainment' then 'Entertainment'
        else Channel2
    end as Tv_Channel
from `bright_tv`.`default`.`bright_tv_vierweship`;


  ---------------------------------------------------------------------------
 -- date function 
 -- extract date, day, dayname and monthname
 -- sort your date
  ---------------------------------------------------------------------------
SELECT
SUM(HOUR(`Duration 2`) * 60 + MINUTE(`Duration 2`)) / 60 AS Total_Hours
FROM `bright_tv`.`default`.`bright_tv_vierweship`;

SELECT RecordDate2,
    date(RecordDate2) AS watch_date,
    dayname(RecordDate2) AS dayname,
    monthname(RecordDate2) AS monthname,
    date_format(RecordDate2, 'HH:mm:ss') as watch_time,
    hour(RecordDate2) as hour_of_day,
    to_char(RecordDate2,'yyyyMM') as month_id,
    dayofweek(RecordDate2) as day_of_week,
    Case 
        when date_format(RecordDate2, 'HH:mm:ss') between '00:00:00' and '05:59:59' then '01. Late Night'
        when date_format(RecordDate2, 'HH:mm:ss') between '06:00:00' and '11:59:59' then '02. Morning'
        when date_format(RecordDate2, 'HH:mm:ss') between '12:00:00' and '16:59:59' then '03. Afternoon'
        when date_format(RecordDate2, 'HH:mm:ss') between '17:00:00' and '23:59:59' then '04. Evening'
    end as day_classification,
   CASE
        WHEN DAYNAME(RecordDate2) IN ('Mon','Tue','Wed','Thu','Fri')THEN 'Weekday'
        ELSE 'Weekend'
    END AS day_classification
FROM `bright_tv`.`default`.`bright_tv_vierweship`;




  ---------------------------------------------------------------------------
 -- identify number of user and active users
  ---------------------------------------------------------------------------
Select count(*) as num_rows,
      count(coalesce(UserID0,userid4,0)) as number_of_subscriber,
      count( distinct coalesce(UserID0,userid4)) as active_users
FROM `bright_tv`.`default`.`bright_tv_vierweship`;


  ---------------------------------------------------------------------------
 -- duration of subcribers spent on viewing
  ---------------------------------------------------------------------------
SELECT
    SUM(HOUR(`Duration 2`) * 60 + MINUTE(`Duration 2`)) / 60 AS Total_Hours,
     AVG(HOUR(`Duration 2`) * 60 + MINUTE(`Duration 2`)) AS Avg_Minutes,
    date_format(`Duration 2`, 'HH:mm:ss') AS duration,

    CASE
        WHEN date_format(`Duration 2`, 'HH:mm:ss') BETWEEN '00:00:00' AND '00:29:59' THEN 'Short'
        WHEN date_format(`Duration 2`, 'HH:mm:ss') BETWEEN '00:30:00' AND '00:59:59' THEN 'Moderate'
        ELSE 'Long'
    END AS screen_time

FROM `bright_tv`.`default`.`bright_tv_vierweship`
GROUP BY date_format(`Duration 2`, 'HH:mm:ss'),
    CASE
        WHEN date_format(`Duration 2`, 'HH:mm:ss') BETWEEN '00:00:00' AND '00:29:59' THEN 'Short'
        WHEN date_format(`Duration 2`, 'HH:mm:ss') BETWEEN '00:30:00' AND '00:59:59' THEN 'Moderate'
        ELSE 'Long'
    END ;

select min(date_format(`Duration 2`, 'HH:mm:ss')) as min_duration,
       max(date_format(`Duration 2`, 'HH:mm:ss')) as max_duration
FROM `bright_tv`.`default`.`bright_tv_vierweship`;

---------------------------------------------------------------------------
-- Subscriber classification based on UserID
---------------------------------------------------------------------------

SELECT
    COALESCE(UserID0, UserID4) AS UserID,
    CASE
        WHEN COALESCE(UserID0, UserID4) IS NULL THEN 'Non-Subscriber'
        ELSE 'Subscriber'
    END AS subscriber_status
FROM `bright_tv`.`default`.`bright_tv_vierweship`;

  ---------------------------------------------------------------------------
 -- create ctes for final dataset for anylsis and dashbourd
 -- perform inner join
  ---------------------------------------------------------------------------

WITH user_profile AS (
    SELECT 
        UserID,

        case
            when Gender in ('None', ' ') then 'Unclassified'
            else Gender
        end as Gender,
        CASE
            WHEN Race IN ('None', ' ') THEN 'Other'
            ELSE Race
        END AS Race,
        Age,
        CASE
            WHEN Age BETWEEN 0 AND 18 THEN 'Teenage'
            WHEN Age BETWEEN 19 AND 35 THEN 'Adult'
            WHEN Age BETWEEN 36 AND 60 THEN 'Older Adult'
            WHEN Age BETWEEN 61 AND 75 THEN 'Grand Parents'
            ELSE 'Older Grand Parents'
        END AS Age_brackets,
        CASE
            WHEN Province IN ('None', ' ') THEN 'Not Provided'
            ELSE Province
        END AS Province,
        CASE
             WHEN Email IS NOT NULL 
             AND Email NOT IN ('', ' ', 'None') THEN 1
            ELSE 0
        END AS email_flag,
        CASE
            WHEN `Social Media Handle` IS NOT NULL 
             AND `Social Media Handle` NOT IN ('', ' ', 'None') THEN 1
            ELSE 0
        END AS smh_flag
    FROM `bright_tv`.`default`.`demographics`
),

viewership as (
  Select COALESCE(UserID0, UserID4) AS UserID,
    CASE
        WHEN COALESCE(UserID0, UserID4) IS NULL THEN 'Non-Subscriber'
        ELSE 'Subscriber'
    END AS subscriber_status,

    case 
        when Channel2 in ('SuperSport Live Events','Live on SuperSport','Supersport Live Events','DStv Events 1') then 'Live Event'
        when Channel2 in ('Sawsee','SawSee') then 'SawSee'
        when Channel2 = 'E! Entertainment' then 'Entertainment'
        else Channel2
    end as Channel,
 RecordDate2,
    date(RecordDate2) AS watch_date,
    dayname(RecordDate2) AS dayname,
    monthname(RecordDate2) AS monthname,
    date_format(RecordDate2, 'HH:mm:ss') as watch_time,
    hour(RecordDate2) as hour_of_day,
    to_char(RecordDate2,'yyyyMM') as month_id,
    dayofweek(RecordDate2) as day_of_week,
    Case 
        when date_format(RecordDate2, 'HH:mm:ss') between '00:00:00' and '05:59:59' then '01. Late Night'
        when date_format(RecordDate2, 'HH:mm:ss') between '06:00:00' and '11:59:59' then '02. Morning'
        when date_format(RecordDate2, 'HH:mm:ss') between '12:00:00' and '16:59:59' then '03. Afternoon'
        when date_format(RecordDate2, 'HH:mm:ss') between '17:00:00' and '23:59:59' then '04. Evening'
    end as day_classification,
   CASE
        WHEN DAYNAME(RecordDate2) IN ('Mon','Tue','Wed','Thu','Fri')THEN 'Weekday'
        ELSE 'Weekend'
    END AS day_type,
    date_format(`Duration 2`, 'HH:mm:ss') AS duration,

    CASE
        WHEN date_format(`Duration 2`, 'HH:mm:ss') BETWEEN '00:00:00' AND '00:29:59' THEN 'Short'
        WHEN date_format(`Duration 2`, 'HH:mm:ss') BETWEEN '00:30:00' AND '00:59:59' THEN 'Moderate'
        ELSE 'Long'
    END AS screen_time
    FROM `bright_tv`.`default`.`bright_tv_vierweship`
)

SELECT a.UserID,
       b.subscriber_status,
       a.Gender,
       a.Race,
       a.email_flag,
       a.smh_flag,
       a.Age_brackets,
       a.Province,
       b.Channel,
       b.watch_date,
       b.dayname,
       b.monthname,
       b.watch_time,
       b.hour_of_day,
       b.day_classification,
       b.day_type,
       b.duration,
       b.screen_time
FROM user_profile as a
inner JOIN viewership as b
 ON a.UserID = b.UserID
 group by all;
