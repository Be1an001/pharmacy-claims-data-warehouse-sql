# SQL Notes

This folder contains the main MySQL script for the project:

- [`pharmacy_claims_star_schema_queries.sql`](pharmacy_claims_star_schema_queries.sql)

The script assumes **MySQL 8+** because the final reporting query uses a CTE and `ROW_NUMBER()`.

## What the SQL File Covers

The SQL file includes:
- database creation
- table creation
- primary key setup
- foreign key setup
- manual sample inserts
- reporting queries

This is a manual SQL workflow. The repository does not include automated CSV loading, dbt, Airflow, Docker, or a deployed database environment.

## Main Tables

- `dim_member`
- `dim_drug`
- `fact_prescription`

The fact table grain is one prescription fill event for one member, one drug, and one fill date.

## Key Design Choices

### Primary Keys

- `dim_member.member_id` - natural key from the sample data
- `dim_drug.drug_ndc` - natural key from the sample data
- `fact_prescription.fill_id` - surrogate key created in MySQL

### Foreign Keys

- `fact_prescription.member_id -> dim_member.member_id`
- `fact_prescription.drug_ndc -> dim_drug.drug_ndc`

### Referential Actions

For both foreign keys, the script uses:
- `ON DELETE RESTRICT`
- `ON UPDATE CASCADE`

I used `RESTRICT` for deletes because prescription fill records should not lose their member or drug context. I used `CASCADE` for updates so key changes would stay aligned if a dimension key were updated.

## Reporting Queries

The project ends with three SQL reporting queries for the small course sample.

### Query 1 - Prescription Count by Drug

This query joins the fact table to `dim_drug`, groups by drug name, and counts prescription fills.

![Query 1 Output](../outputs/figures/01-sql-query-1-prescription-count-by-drug.png)

### Query 2 - Member Age Group Analysis

This query joins the fact table to `dim_member`, uses CASE logic for age groups, and summarizes prescriptions, members, copay, and insurance-paid totals. The SQL file uses a fixed as-of date so the documented outputs stay stable.

![Query 2 Output](../outputs/figures/02-sql-query-2-member-age-group-analysis.png)

### Query 3 - Most Recent Prescription Fill by Member

This query uses a CTE and `ROW_NUMBER()` to identify the most recent fill for each member.

![Query 3 Output](../outputs/figures/03-sql-query-3-most-recent-fill-analysis.png)

## Review Notes

The SQL script can be reviewed as the main source of truth for the schema and reporting logic. The output screenshots show the expected results for the sample data, but the project is not packaged as a one-click build.

## Related Files

- [Project walkthrough](../walkthrough/project-walkthrough.md)
- [Data note](../data/README.md)
- [Outputs gallery](../outputs/README.md)
- [Original course report](../reports/cheng-liu-final-project-report.pdf)
- [Original ERD PDF](../reports/cheng-liu-final-project-erd.pdf)
