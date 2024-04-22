-- Which campaign categories had the highest signups?
SELECT campaign_category
     , ROUND(COUNT(customer_id) / SUM(COUNT(customer_id)) OVER () * 100, 2) AS signup_rate
FROM `RowHealth.customers-staging`
LEFT JOIN `RowHealth.campaigns-staging`
  ON `RowHealth.customers-staging`.campaign_id = `RowHealth.campaigns-staging`.campaign_id
GROUP BY campaign_category
ORDER BY 2 DESC;

-- campaign_category  signup_rate
-- #HealthyLiving 22.81
-- Health For All 21.7
-- #CoverageMatters 21.64
-- Compare Health Coverage  17.26
-- Tailored Health Plans  6.78
-- Preventive Care News 3.94
-- #InsureYourHealth  1.93
-- Family Coverage Plan 1.84
-- Summer Wellness Tips 1.0
-- Affordable Plans 0.39
-- Null 0.3
-- Benefit Updates  0.28
-- Golden Years Security  0.14