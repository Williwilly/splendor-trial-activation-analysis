# Trial Activation Analysis
## Splendor Analytics — Data Analyst Community Challenge

### Overview
This project defines what "Trial Activation" means for Splendor Analytics' 
workforce management platform, identifies the behaviours that signal genuine 
product adoption, and builds the data infrastructure to track activation at scale.

**Dataset:** 170,526 raw behavioural events from 966 organisations that started 
their trial between January and March 2024.

---

### Key Findings

#### 1. The Onboarding Problem
61% of trialling organisations never return after Day 0. This is not primarily 
a conversion problem — it is an onboarding problem. Organisations are being 
lost before they experience the core value of the product.

#### 2. Engagement Volume Does Not Predict Conversion
After testing four analytical approaches — engagement volume, module-level 
usage, individual activity analysis, and timing of activities — no single 
behavioural signal reliably separates converters from non-converters:

- Converters average 107.9 events vs 106.1 for non-converters
- Converters average 4.2 active days vs 4.2 for non-converters
- Timing of first activity is virtually identical across both groups

#### 3. Conversion Is Likely Driven by External B2B Factors
The weak predictive power of in-app behaviour suggests conversion decisions 
are influenced by external factors — sales engagement, pricing negotiations, 
procurement cycles — rather than product usage alone. This is consistent with 
typical B2B SaaS buying behaviour where the decision maker and the product 
user are often different people.

#### 4. Scheduling Is the Gateway Module
Zero organisations converted without using the Scheduling module. It is the 
entry point to the entire product value loop — without creating shifts, no 
other module can be meaningfully used.

#### 5. The Core Value Loop
Analysis of the product's activity structure reveals a natural operational 
workflow that defines genuine product adoption:
```
Create Shift → View Schedule → Assign Shift → Clock In/Out → Approve for Payroll
```

---

### Trial Goal Definitions
Trial Goals are defined around the core value loop — milestones that signal 
an organisation has genuinely experienced the product's value. Thresholds are 
set based on the nature of each activity and distribution analysis.

| Goal | Activity | Threshold | Rationale |
|------|----------|-----------|-----------|
| Goal 1: First Shift Created | Scheduling.Shift.Created | ≥1 | Gateway activity — entry point to all product value |
| Goal 2: Schedule Viewed | Mobile.Schedule.Loaded | ≥3 | Employees actively checking schedules signals team adoption |
| Goal 3: Shift Assigned | Scheduling.Shift.AssignmentChanged | ≥1 | Active workforce management beyond basic setup |
| Goal 4: Time Tracked | PunchClock.PunchedIn | ≥3 | Operational habit — employees consistently clocking in |
| Goal 5: Payroll Approved | Scheduling.Shift.Approved | ≥1 | Connects scheduling to payroll — deep workflow integration |

**Trial Activation** is defined as completing 3 or more of the 5 trial goals. 
This threshold reflects breadth of engagement, depth of use, and integration 
with operational workflows — without being so restrictive that it becomes 
unreachable.

> **Note:** These goals are defined as hypotheses grounded in product-value 
> logic and supported by data evidence. They represent what genuine product 
> adoption looks like, not guaranteed conversion levers.

---

### Activation Results

| Metric | Value |
|--------|-------|
| Total organisations | 966 |
| Overall conversion rate | 21.3% |
| Organisations lost on Day 0 | 590 (61%) |
| Activated organisations (≥3 goals) | 257 (26.6%) |
| Goal 1 completion rate | 87.8% |
| Goal 2 completion rate | 36.0% |
| Goal 3 completion rate | 35.5% |
| Goal 4 completion rate | 12.9% |
| Goal 5 completion rate | 20.7% |

---

### Recommendations

**1. Fix Onboarding First**
With 61% of organisations disappearing after Day 0, the priority intervention 
is improving the onboarding experience — not optimising the conversion ask. 
Get organisations to Goal 2 and Goal 3 before worrying about conversion.

**2. Implement Conversion Nudges for Group 2 Users**
Organisations with high engagement but no conversion (price-sensitive users) 
should receive targeted interventions in the final days of their trial:
- Timing: Days 25–30
- Message: Value delivered during trial
- Incentive: Time-sensitive discount before trial expires

**3. Combine Product Analytics with Sales Data**
Since in-app behaviour weakly predicts conversion, future analysis should 
incorporate sales touchpoint data — demo requests, email opens, sales calls — 
to build a more complete conversion model.

---

### Repository Structure
```
├── trial_activation_analysis.ipynb  ← Main analysis notebook (Tasks 1 & 3)
├── models/
│   ├── staging/
│   │   └── stg_events.sql           ← Staging layer: cleaned event data
│   └── marts/
│       ├── mart_trial_goals.sql     ← Trial Goals mart model
│       └── mart_trial_activation.sql ← Trial Activation mart model
├── trial_activation_analysis.png    ← Visualisations
├── requirements.txt                 ← Python dependencies
└── README.md                        ← This file
```

---

### How to Run

1. Clone this repository
2. Install dependencies:
```bash
pip install -r requirements.txt
```
3. Place `DA task.csv` in the root directory
4. Open and run `trial_activation_analysis.ipynb` from top to bottom
5. SQL models in `models/` can be run against any SQL engine using 
   `stg_events` as the base layer

---

### Dependencies
- Python 3.8+
- pandas
- duckdb
- matplotlib
- jupyter

---

*Submitted for the Splendor Analytics Data Analyst Community Challenge*
