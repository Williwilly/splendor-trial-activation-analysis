-- Staging model: cleans raw event data and derives trial_day
-- Removes duplicate events using ROW_NUMBER()
-- Casts all timestamp columns to proper datetime format

SELECT
    ORGANIZATION_ID                                    AS organisation_id,
    ACTIVITY_NAME                                      AS activity_name,
    CAST(TIMESTAMP AS TIMESTAMP)                       AS event_timestamp,
    CAST(TRIAL_START AS TIMESTAMP)                     AS trial_start,
    CAST(TRIAL_END AS TIMESTAMP)                       AS trial_end,
    CAST(CONVERTED AS BOOLEAN)                         AS converted,
    CAST(CONVERTED_AT AS TIMESTAMP)                    AS converted_at,
    DATEDIFF('day', TRIAL_START, TIMESTAMP)            AS trial_day
FROM raw.da_task
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY ORGANIZATION_ID, ACTIVITY_NAME, TIMESTAMP
    ORDER BY TIMESTAMP
) = 1
