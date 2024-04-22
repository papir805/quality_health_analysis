-- How many ads did each campaign run
SELECT campaign_category
     , COUNT(campaign_id) AS ad_count
FROM `RowHealth.campaigns-staging`
GROUP BY campaign_category
ORDER BY 2 DESC;

-- campaign_category	ad_count
-- Compare Health Coverage	8
-- #HealthyLiving	6
-- #InsureYourHealth	6
-- Preventive Care News	6
-- Summer Wellness Tips	6
-- Golden Years Security	5
-- Tailored Health Plans	5
-- Health For All	4
-- #CoverageMatters	3
-- Affordable Plans	3
-- Family Coverage Plan	3
-- Benefit Updates	2