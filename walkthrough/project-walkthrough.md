# Project Walkthrough

## Project Overview

This project was my final project for **ALY6030: Data Warehousing & SQL** in **Spring 2025**. It uses a small course-provided pharmacy claims sample to practice SQL data modeling and reporting.

The raw file was not organized well for relational reporting because it mixed member details, drug details, and repeated fill events in one table. The main goal was to turn that raw input into a cleaner structure that could support simple SQL reports.

## Business Problem

In the assignment scenario, a PBM provides a small sample of pharmacy claims data before a larger production file is available. The sample is useful for planning the data model, but the raw format is not easy for analysts to query.

The reporting problem comes from the wide layout:
- member and drug attributes are stored together
- one raw row can contain multiple fill dates
- repeated copay and insurance-paid fields make aggregation less direct
- the same member can appear in more than one raw row

This project addresses that structure by separating the data into member, drug, and prescription fill tables.

## Project Objective

The goal was to:

1. review the raw input structure
2. split repeated fill fields into fill-level records
3. create member and drug dimensions
4. build a MySQL schema with primary and foreign keys
5. create an ERD for the schema
6. write sample SQL reporting queries

This is a small coursework prototype, not a production PBM implementation.

## Dataset and Scope

The original raw file has:
- 5 rows
- 21 columns
- member fields
- drug fields
- repeated fill, copay, and insurance-paid columns

Example repeated columns:
- `fill_date1`, `fill_date2`, `fill_date3`
- `copay1`, `copay2`, `copay3`
- `insurancepaid1`, `insurancepaid2`, `insurancepaid3`

After restructuring:
- `dim_member.csv` has 4 rows
- `dim_drug.csv` has 4 rows
- `fact_prescription.csv` has 11 fill-level rows

The sample uses made-up members for classroom use. The query results should be read as sample-level outputs only.

## Methodology

The workflow was:

1. Review the raw table and data dictionary.
2. Identify repeated fields and member-drug row structure.
3. Split the raw data into dimension and fact CSV tables.
4. Create the MySQL database objects.
5. Define primary keys and foreign keys.
6. Use referential actions to protect the fact table relationships.
7. Create an ERD.
8. Write reporting SQL queries.
9. Save SQL output screenshots and portfolio charts.

## SQL / Data Model Note

The model uses one fact table and two dimension tables:

- `dim_member`
- `dim_drug`
- `fact_prescription`

The fact table grain is:

> one prescription fill event for one member, for one drug, on one fill date

The SQL script uses:
- MySQL table creation
- natural keys for `dim_member.member_id` and `dim_drug.drug_ndc`
- a surrogate `fill_id` key for `fact_prescription`
- foreign keys from the fact table to both dimensions
- joins, aggregation, CASE logic, a CTE, and `ROW_NUMBER()`

The full SQL file is here:

- [`../sql/pharmacy_claims_star_schema_queries.sql`](../sql/pharmacy_claims_star_schema_queries.sql)

### ERD

The ERD shows the fact table connected to the member and drug dimensions.

![ERD](../outputs/figures/04-erd-pharmacy-claims-star-schema.png)

## Key Findings

The SQL outputs answer the course reporting questions for this small sample:

- Ambien had 5 fills in the sample.
- Risperidone had 3 fills.
- Diprosone had 2 fills.
- Amoxicillin had 1 fill.
- The `age 65+` group had 1 unique member and 6 total prescriptions.
- Member `10003` most recently filled Ambien on 2018-05-16, with insurance paid of $322.

These findings describe only the classroom sample and should not be generalized to real pharmacy utilization or healthcare cost trends.

## SQL Output Evidence

### Query 1 - Number of Prescriptions Grouped by Drug Name

![Query 1](../outputs/figures/01-sql-query-1-prescription-count-by-drug.png)

### Query 2 - Member Age Group Analysis

![Query 2](../outputs/figures/02-sql-query-2-member-age-group-analysis.png)

### Query 3 - Most Recent Prescription Fill Analysis

![Query 3](../outputs/figures/03-sql-query-3-most-recent-fill-analysis.png)

## Visual Highlights

The portfolio charts are static visuals based on the final SQL outputs. They are included to make the small sample easier to scan.

### Prescription Count by Drug

![Prescription Count by Drug](../outputs/figures/05-chart-prescription-count-by-drug.png)

### Insurance Paid by Drug

![Insurance Paid by Drug](../outputs/figures/06-chart-insurance-paid-by-drug.png)

### Fill Timeline by Member

![Fill Timeline by Member](../outputs/figures/07-chart-fill-timeline-by-member.png)

## My Role / Contribution

This was an individual course final project. The schema setup, normalized tables, SQL file, ERD, and write-up in this repo reflect my own course work for the assignment.

For the formal contribution note, see:

- [`../contribution-note.md`](../contribution-note.md)

## Limitations

- The dataset is very small and course-provided.
- The data uses made-up members for classroom use.
- The workflow is manual and not an automated ETL pipeline.
- The screenshots and charts are static outputs, not a deployed dashboard.
- The project does not include machine learning, GenAI, MLOps, or production monitoring.
- The sample-level results should not be interpreted as real healthcare trends.

## What I Learned

This project helped me practice:

- thinking about data structure before writing queries
- separating raw input from reporting-ready tables
- defining a fact table grain
- choosing primary keys and foreign keys
- using SQL for reporting questions
- explaining a small data model clearly

## Related Files

- [Back to README](../README.md)
- [Data note](../data/README.md)
- [SQL notes](../sql/README.md)
- [Outputs gallery](../outputs/README.md)
- [Portfolio PDF](../reports/aly6030-pharmacy-claims-portfolio.pdf)
- [Original course report](../reports/cheng-liu-final-project-report.pdf)
