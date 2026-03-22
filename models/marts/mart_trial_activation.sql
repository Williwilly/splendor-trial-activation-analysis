-- Mart model: Trial Activation
-- One row per organisation showing trial activation status
-- An organisation is activated if they complete 3 or more trial goals
-- Threshold reflects breadth of engagement, depth of use,
-- and integration with operational workflows

WITH goal_counts AS (
    SELECT
        organisation_id,
        (CAST(goal_1_shift_created AS INTEGER)
        + CAST(goal_2_schedule_viewed AS INTEGER)
        + CAST(goal_3_shift_assigned AS INTEGER)
        + CAST(goal_4_time_tracked AS INTEGER)
        + CAST(goal_5_payroll_approved AS INTEGER)) AS goals_completed
    FROM mart_trial_goals
)

SELECT
    organisation_id,
    goals_completed,
    CASE 
        WHEN goals_completed >= 3 
        THEN TRUE 
        ELSE FALSE 
    END                         AS is_activated
FROM goal_counts
