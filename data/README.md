# Data Note

This folder contains the small course-provided pharmacy claims sample and the processed CSV tables used in the MySQL schema.

The data is included so the project can be reviewed in the same form as the original course assignment. It should be treated as a made-up classroom sample, not as real pharmacy claims data.

## Source

The dataset came from the ALY6030 final project assignment.

Reference file:
- [`../archive/final-project-instructions.pdf`](../archive/final-project-instructions.pdf)

## Folder Structure

- [`raw/final_project_data.csv`](raw/final_project_data.csv) - original wide-format course sample
- [`raw/final_project_data_description.csv`](raw/final_project_data_description.csv) - raw field descriptions and formats
- [`processed/dim_member.csv`](processed/dim_member.csv) - member dimension table
- [`processed/dim_drug.csv`](processed/dim_drug.csv) - drug dimension table
- [`processed/fact_prescription.csv`](processed/fact_prescription.csv) - prescription fill fact table

## Raw Data Structure

The raw file has 5 rows and 21 columns. It includes member fields, drug fields, and repeated fill columns in the same table.

Repeated fields include:
- `fill_date1`, `fill_date2`, `fill_date3`
- `copay1`, `copay2`, `copay3`
- `insurancepaid1`, `insurancepaid2`, `insurancepaid3`

This layout is useful for a small assignment sample, but it is not a clean reporting structure for relational SQL. A query would have to handle repeated fill columns instead of working with one fill event per row.

## Processed Data Model

The processed files split the raw structure into one member dimension, one drug dimension, and one prescription fact table.

| Table | Rows | Grain / purpose |
|---|---:|---|
| `dim_member.csv` | 4 | one row per member |
| `dim_drug.csv` | 4 | one row per drug |
| `fact_prescription.csv` | 11 | one row per prescription fill event |

## Fact Table Grain

Each row in `fact_prescription.csv` represents one prescription fill event for one member, for one drug, on one fill date.

The fact table contains:
- `member_id`
- `drug_ndc`
- `fill_date`
- `copay`
- `insurance_paid`

The SQL script adds a surrogate `fill_id` when creating the MySQL fact table.

## Dimension Columns

### Member Dimension

File: [`processed/dim_member.csv`](processed/dim_member.csv)

- `member_id`
- `member_first_name`
- `member_last_name`
- `member_birth_date`
- `member_gender`

### Drug Dimension

File: [`processed/dim_drug.csv`](processed/dim_drug.csv)

- `drug_ndc`
- `drug_name`
- `drug_form_code`
- `drug_form_desc`
- `drug_brand_generic_code`
- `drug_brand_generic_desc`

## Data Notes and Limitations

- The data is intentionally tiny because it comes from a course assignment.
- Some repeated fill fields are blank in the raw file because not every member-drug row has three fills.
- The raw file includes `member_age`, but the processed member dimension keeps the birth date instead.
- The sample contains made-up names and health-related fields for classroom use.
- Query results from this data should not be generalized to real pharmacy utilization or cost patterns.

## ERD Preview

The ERD shows how the processed tables connect in the MySQL schema.

![ERD Preview](../outputs/figures/04-erd-pharmacy-claims-star-schema.png)

## Related Files

- [Main SQL script](../sql/pharmacy_claims_star_schema_queries.sql)
- [SQL notes](../sql/README.md)
- [Project walkthrough](../walkthrough/project-walkthrough.md)
- [Outputs gallery](../outputs/README.md)
- [Original course report](../reports/cheng-liu-final-project-report.pdf)
