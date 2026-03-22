-- Mart model: Trial Goals
-- One row per organisation showing completion of each trial goal
-- Goals defined based on core value loop analysis

WITH activity_counts AS (
    SELECT
        organisation_id,
        activity_name,
        COUNT(*)        AS event_count
    FROM stg_events
    GROUP BY organisation_id, activity_name
),

goal_flags AS (
    SELECT
        organisation_id,

        -- Goal 1: First Shift Created (>=1)
        -- Gateway activity - entry point to core product value
        MAX(CASE 
            WHEN activity_name = 'Scheduling.Shift.Created' 
            AND event_count >= 1 
            THEN TRUE ELSE FALSE 
        END)            AS goal_1_shift_created,

        -- Goal 2: Schedule Viewed (>=3)
        -- Employees are actively checking their schedules
        MAX(CASE 
            WHEN activity_name = 'Mobile.Schedule.Loaded' 
            AND event_count >= 3 
            THEN TRUE ELSE FALSE 
        END)            AS goal_2_schedule_viewed,

        -- Goal 3: Shift Assigned (>=1)
        -- Shifts are being actively managed and assigned
        MAX(CASE 
            WHEN activity_name = 'Scheduling.Shift.AssignmentChanged' 
            AND event_count >= 1 
            THEN TRUE ELSE FALSE 
        END)            AS goal_3_shift_assigned,

        -- Goal 4: Time Tracked (>=3)
        -- Employees consistently clocking in
        -- Threshold set at 3 to confirm operational habit
        MAX(CASE 
            WHEN activity_name = 'PunchClock.PunchedIn' 
            AND event_count >= 3 
            THEN TRUE ELSE FALSE 
        END)            AS goal_4_time_tracked,

        -- Goal 5: Payroll Approved (>=1)
        -- Organisation connecting scheduling to payroll workflow
        MAX(CASE 
            WHEN activity_name = 'Scheduling.Shift.Approved' 
            AND event_count >= 1 
            THEN TRUE ELSE FALSE 
        END)            AS goal_5_payroll_approved

    FROM activity_counts
    GROUP BY organisation_id
)

SELECT * FROM goal_flags
