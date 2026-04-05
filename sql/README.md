# SQL Notes

This folder contains the main SQL file for the project.

The script assumes **MySQL 8+** because the final reporting section uses a CTE and `ROW_NUMBER()`.

## Main File

- [`pharmacy_claims_star_schema_queries.sql`](pharmacy_claims_star_schema_queries.sql)

## What the SQL File Covers

The SQL file includes:
- database creation
- table creation
- primary key setup
- foreign key setup
- sample inserts
- reporting queries

The workflow is reproducible from the files in this repo, but it is set up as a manual SQL project rather than a one-click automated build.

## Main Tables

- `dim_member`
- `dim_drug`
- `fact_prescription`

## Key Design Choices

### Primary keys
- `dim_member.member_id` - natural key
- `dim_drug.drug_ndc` - natural key
- `fact_prescription.fill_id` - surrogate key

### Foreign keys
- `fact_prescription.member_id -> dim_member.member_id`
- `fact_prescription.drug_ndc -> dim_drug.drug_ndc`

### Referential actions
For both foreign keys, I used:
- `ON DELETE RESTRICT`
- `ON UPDATE CASCADE`

I used `RESTRICT` for deletes because I did not want historical fill records to lose their dimension references. I used `CASCADE` for updates so key changes would stay aligned.

## Reporting Queries

The project ends with three business-facing SQL queries.

### Query 1 - Prescription count by drug

![Query 1 Output](../outputs/figures/01-sql-query-1-prescription-count-by-drug.png)

### Query 2 - Member age group analysis

This query uses a fixed as-of date in the SQL file so the age-group results stay aligned with the documented portfolio outputs.

![Query 2 Output](../outputs/figures/02-sql-query-2-member-age-group-analysis.png)

### Query 3 - Most recent prescription fill by member

![Query 3 Output](../outputs/figures/03-sql-query-3-most-recent-fill-analysis.png)

## Related Files

- [Project walkthrough](../walkthrough/project-walkthrough.md)
- [Data note](../data/README.md)
- [Outputs gallery](../outputs/README.md)
- [Original report](../reports/cheng-liu-final-project-report.pdf)
- [Original ERD PDF](../reports/cheng-liu-final-project-erd.pdf)
