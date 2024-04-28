-- MARKETING METRICS

--Q1: What is the cost per impression?
-- Calculate total cost / total impressions for each campaign category
-- and order from lowest to highest cost
SELECT campaign_category
     , ROUND(SUM(cost) / SUM(impressions), 4) AS cost_per_impression
FROM `rowhealth-419822.RowHealth.campaigns-staging`
GROUP BY campaign_category
ORDER BY 2 ASC;


--Q2: What is the average, min, and max cost per impression?
-- Create CTE that calculates and stores the cost per impression for
-- each campaign category.
WITH cost_per_impressions AS (
     SELECT campaign_category
          , SUM(cost) / SUM(impressions) AS cpi
     FROM `rowhealth-419822.RowHealth.campaigns-staging`
     GROUP BY campaign_category
)

-- Find the average, minimum, and maximum cost per impression from the CTE
SELECT 'average' AS metric, ROUND(AVG(cpi), 4) AS cost_per_impression
FROM cost_per_impressions
  UNION ALL
SELECT 'minimum', ROUND(MIN(cpi), 4)
FROM cost_per_impressions
  UNION ALL
SELECT 'maximum', ROUND(MAX(cpi), 4)
FROM cost_per_impressions
ORDER BY
  CASE
    WHEN metric = 'average' THEN 1
    WHEN metric = 'minimum' THEN 2
    ELSE 3
  END;

--Q3: Which campaigns had the highest click through rates?
-- Calculate total clicks / total impressions to get the click through rate.
-- Campaigns with no clicks or no impressions will be null and coalesced to 0.
SELECT campaign_category
     , ROUND(
          (COALESCE(SUM(clicks), 0) /
               COALESCE(SUM(impressions), 0) * 100), 2
          ) AS click_through_rate
FROM `RowHealth.campaigns-staging`
GROUP BY campaign_category
ORDER BY 2 DESC;

-- SIGNUP METRICS

--Q1: Which campaign categories had the highest signups?
-- Calculate customer count / total number of customers for each
-- campaing category.  Use SUM OVER () to aggregate the counts and get the total
-- after they're grouped by campaign category 
SELECT campaign_category
     , ROUND(COUNT(customer_id) / 
          SUM(COUNT(customer_id)) OVER () * 100, 2) AS signup_rate
FROM `RowHealth.customers-staging`
LEFT JOIN `RowHealth.campaigns-staging`
  ON `RowHealth.customers-staging`.campaign_id = `RowHealth.campaigns-staging`.campaign_id
GROUP BY campaign_category
ORDER BY 2 DESC;

--Q2: What are the yearly signup counts?
-- Extract year from signup_date and group by year.  Count the number of
-- customer_ids for each year to identify how many customers signed up
SELECT EXTRACT(YEAR FROM signup_date) AS year
     , COUNT(customer_id) AS signup_count
FROM `rowhealth-419822.RowHealth.customers-staging`
GROUP BY EXTRACT(YEAR FROM signup_date)
ORDER BY 1 ASC;

-- CLAIM METRICS

--Q1: What is the average average claim amount and how many claims were made?
-- Calculate total claim amounts / claim count and round to 2 decimal places
-- to get the average claim amount
-- Also count the number of claims made 
SELECT ROUND(SUM(claim_amount) / COUNT(claim_id), 2) AS avg_claim_amount
     , COUNT(claim_id) AS claim_count
FROM `rowhealth-419822.RowHealth.claims-staging`;

-- RECOMMENDATIONS

--Q1: How many ads did each campaign run?
-- Each ad within a campaign has a campaign ID.  Count the number of campaign IDs
-- within a campaign category to know how many ads it ran.
SELECT campaign_category
     , COUNT(campaign_id) AS ad_count
FROM `RowHealth.campaigns-staging`
GROUP BY campaign_category
ORDER BY 2 DESC;