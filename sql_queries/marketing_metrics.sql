-- What is the cost per impression?
SELECT campaign_category
     , ROUND(SUM(cost) / SUM(impressions), 4) AS cost_per_impression
FROM `rowhealth-419822.RowHealth.campaigns-staging`
GROUP BY campaign_category
ORDER BY 2 ASC;

-- campaign_category     cost_per_impression
-- #CoverageMatters 0.0032
-- Family Coverage Plan  0.0036
-- Tailored Health Plans 0.0037
-- Affordable Plans 0.0048
-- #HealthyLiving   0.0049
-- Preventive Care News  0.0056
-- #InsureYourHealth     0.0068
-- Benefit Updates  0.0088
-- Golden Years Security 0.0096
-- Summer Wellness Tips  0.0124
-- Compare Health Coverage    0.0151
-- Health For All   0.0255

-- What is the average, min, and max cost per impression
WITH cost_per_impressions AS (
     SELECT campaign_category
          , SUM(cost) / SUM(impressions) AS cpi
     FROM `rowhealth-419822.RowHealth.campaigns-staging`
     GROUP BY campaign_category
)

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

-- metric cost_per_impression
-- average     0.0087
-- minimum     0.0032
-- maximum     0.0255

-- Which campaigns had the highest click through rates?
SELECT campaign_category
     , ROUND((COALESCE(SUM(clicks), 0) / SUM(impressions) * 100), 2) AS click_through_rate
FROM `RowHealth.campaigns-staging`
GROUP BY campaign_category
ORDER BY 2 DESC;

-- campaign_category     click_through_rate
-- Health For All   25.48
-- Benefit Updates  22.17
-- Summer Wellness Tips  18.09
-- Compare Health Coverage    14.04
-- Affordable Plans 12.7
-- Preventive Care News  12.24
-- #CoverageMatters 10.43
-- #HealthyLiving   9.62
-- #InsureYourHealth     7.68
-- Tailored Health Plans 6.62
-- Golden Years Security 1.41
-- Family Coverage Plan  0.0