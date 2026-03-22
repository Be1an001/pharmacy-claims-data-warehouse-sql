# Data Note

This folder keeps the small course sample that I used for the ALY6030 final project.

## Folder Structure

- [`raw/final_project_data.csv`](raw/final_project_data.csv) - original raw sample
- [`raw/final_project_data_description.csv`](raw/final_project_data_description.csv) - data description / field note
- [`processed/dim_member.csv`](processed/dim_member.csv) - member dimension table
- [`processed/dim_drug.csv`](processed/dim_drug.csv) - drug dimension table
- [`processed/fact_prescription.csv`](processed/fact_prescription.csv) - prescription fact table

## Source

This dataset came from the course final project assignment and was used as the starting sample for the database design task.

Reference file:
- [`../archive/final-project-instructions.pdf`](../archive/final-project-instructions.pdf)

## What the Raw Data Looks Like

The original file is a small wide-format pharmacy claims sample.

### Raw input
- file: [`raw/final_project_data.csv`](raw/final_project_data.csv)
- size: **5 rows x 21 columns**
- includes member fields, drug fields, and repeated fill columns such as:
  - `fill_date1`, `fill_date2`, `fill_date3`
  - `copay1`, `copay2`, `copay3`
  - `insurancepaid1`, `insurancepaid2`, `insurancepaid3`

That structure was okay as a sample input, but not a good reporting structure for a relational warehouse.

## Why I Split the Data

The raw file repeated fill events in one row, so I reorganized it into:
- one member dimension
- one drug dimension
- one fact table for prescription fills

This made the data easier to query and closer to a simple warehouse design.

## Processed Output

### Member dimension
- file: [`processed/dim_member.csv`](processed/dim_member.csv)
- columns:
  - `member_id`
  - `member_first_name`
  - `member_last_name`
  - `member_birth_date`
  - `member_gender`

### Drug dimension
- file: [`processed/dim_drug.csv`](processed/dim_drug.csv)
- columns:
  - `drug_ndc`
  - `drug_name`
  - `drug_form_code`
  - `drug_form_desc`
  - `drug_brand_generic_code`
  - `drug_brand_generic_desc`

### Prescription fact table
- file: [`processed/fact_prescription.csv`](processed/fact_prescription.csv)
- columns:
  - `member_id`
  - `drug_ndc`
  - `fill_date`
  - `copay`
  - `insurance_paid`

## Grain

Each row in `fact_prescription.csv` represents one prescription fill event for one member, for one drug, on one fill date.

## Data Size After Restructuring

| Table | Rows | Notes |
|---|---:|---|
| `dim_member.csv` | 4 | unique members |
| `dim_drug.csv` | 4 | unique drugs |
| `fact_prescription.csv` | 11 | fill-level records |

## ERD Preview

![ERD Preview](../outputs/figures/04-erd-pharmacy-claims-star-schema.png)

## Related Files

- [SQL file](../sql/pharmacy_claims_star_schema_queries.sql)
- [SQL notes](../sql/README.md)
- [Project walkthrough](../walkthrough/project-walkthrough.md)
- [Original report](../reports/cheng-liu-final-project-report.pdf)