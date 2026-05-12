# Pharmacy Claims Data Warehouse SQL Project

This project uses a small course-provided pharmacy claims sample to practice SQL data warehousing, fact/dimension modeling, and reporting queries in MySQL. It is best understood as an individual coursework and portfolio project, not as a production pharmacy claims warehouse.

## Project Type / Status / Tools

| Item | Details |
|---|---|
| Course context | ALY6030: Data Warehousing & SQL, Spring 2025 |
| Project type | Individual SQL / data warehouse modeling project |
| Current status | Manual coursework prototype with static outputs |
| Main tools | MySQL 8+, SQL, CSV / spreadsheet preparation, ERD export |
| Main deliverables | SQL script, processed CSV tables, ERD, SQL output screenshots, report PDFs |

## Business Problem

The assignment scenario starts with a small pharmacy claims sample from a Pharmacy Benefit Manager (PBM). The raw file is not ready for relational reporting because it stores member details, drug details, and repeated prescription fill events in one wide table.

That structure makes basic reporting harder because the same member can appear more than once and each row can contain multiple fill dates, copays, and insurance-paid values. A cleaner fact/dimension model separates member information, drug information, and fill-level events so SQL queries can summarize the data more directly.

## Project Objective

The goal was to convert the small raw sample into a simple MySQL star schema and use it to answer a few reporting questions from the course assignment.

The project focuses on:
- defining the grain of the prescription fact table
- separating member and drug attributes into dimensions
- creating primary key and foreign key relationships
- documenting the schema with an ERD
- writing SQL queries for reporting outputs

## Dataset and Scope

The dataset is a made-up classroom sample included with the course assignment.

| Item | Value |
|---|---:|
| Raw input | 5 rows x 21 columns |
| Member dimension | 4 rows |
| Drug dimension | 4 rows |
| Prescription fact table | 11 fill-level rows |
| Fill date range in the sample | 2017-10-31 to 2018-06-14 |

The raw file includes repeated fields such as `fill_date1`, `fill_date2`, `fill_date3`, `copay1`, `copay2`, `copay3`, `insurancepaid1`, `insurancepaid2`, and `insurancepaid3`. The processed fact table changes that into one row per prescription fill event.

## My Role / Contribution

This was an individual course-based project. I reviewed the raw sample structure, reorganized it into dimension and fact CSV tables, wrote the MySQL schema and reporting queries, created the ERD submission, and prepared the portfolio-facing documentation.

For the formal contribution note, see [contribution-note.md](contribution-note.md).

## Methodology

The project followed a small manual SQL warehouse workflow:

1. Review the wide raw claims sample.
2. Identify repeated fill fields and duplicated member context.
3. Split the data into `dim_member`, `dim_drug`, and `fact_prescription`.
4. Define the fact table grain as one prescription fill event for one member, one drug, and one fill date.
5. Create the schema in MySQL with primary keys and foreign keys.
6. Use `ON DELETE RESTRICT` and `ON UPDATE CASCADE` for the fact table relationships.
7. Build an ERD to show the fact/dimension structure.
8. Write reporting SQL using joins, aggregation, CASE logic, a CTE, and `ROW_NUMBER()`.

## Key Findings

These results describe this small classroom sample only:

- Ambien had the highest prescription count in the sample with 5 fills.
- Ambien also had the highest insurance-paid total at $2,518.
- The `age 65+` group had 1 unique member and 6 total prescriptions.
- Member `10003` most recently filled Ambien on 2018-05-16, with insurance paid of $322.
- The final schema supports reporting from `dim_member`, `dim_drug`, and `fact_prescription`.

These findings should not be interpreted as real pharmacy utilization or healthcare cost trends.

## Visual Highlights

### Star Schema ERD

The ERD shows the intended fact/dimension structure for the small pharmacy claims sample.

![ERD](outputs/figures/04-erd-pharmacy-claims-star-schema.png)

### Prescription Count by Drug

This chart summarizes the course sample only.

![Prescription Count by Drug](outputs/figures/05-chart-prescription-count-by-drug.png)

### Insurance Paid by Drug

This chart shows the sample-level insurance-paid totals by drug.

![Insurance Paid by Drug](outputs/figures/06-chart-insurance-paid-by-drug.png)

## SQL / Data Model Note

The main SQL file creates the database objects, inserts the small sample records, applies primary and foreign keys, and runs the reporting queries. The script assumes MySQL 8+ because the latest-fill query uses a CTE and `ROW_NUMBER()`.

The fact table uses a surrogate `fill_id`, while `member_id` and `drug_ndc` connect back to the member and drug dimensions.

## Repository Structure

| Path | Purpose |
|---|---|
| [`data/raw/`](data/raw/) | Original course sample and data dictionary |
| [`data/processed/`](data/processed/) | Processed dimension and fact CSV tables |
| [`sql/`](sql/) | MySQL schema setup and reporting queries |
| [`walkthrough/`](walkthrough/) | Longer project walkthrough |
| [`outputs/`](outputs/) | SQL output screenshots, ERD image, and static portfolio charts |
| [`reports/`](reports/) | Portfolio PDF and original course report files |
| [`archive/`](archive/) | Assignment prompt used as project context |

## How to Review This Project

This repository is set up for manual review rather than a one-click automated build.

A good review order is:

1. Start with this README for the project summary.
2. Read the [data note](data/README.md) to understand the raw and processed files.
3. Review the [SQL notes](sql/README.md) and main [SQL script](sql/pharmacy_claims_star_schema_queries.sql).
4. Look at the [ERD image](outputs/figures/04-erd-pharmacy-claims-star-schema.png).
5. Check the [outputs gallery](outputs/README.md) for SQL screenshots and charts.
6. Use the [project walkthrough](walkthrough/project-walkthrough.md) for a more detailed explanation.

The SQL script is executable in a MySQL 8+ environment, but the repository does not include an automated ETL pipeline, Docker setup, database server configuration, or deployment workflow.

## Limitations

- The dataset is very small and course-provided.
- The sample members are made up for classroom use.
- The workflow is manual and should not be described as an automated ETL or ELT pipeline.
- The charts and screenshots are static outputs, not a deployed dashboard.
- The project does not include machine learning, GenAI, MLOps, or production monitoring.
- The sample-level results should not be generalized to real pharmacy claims behavior.

## Future Improvements

- Add a repeatable CSV loading workflow instead of relying on manual inserts.
- Add validation queries for row counts, missing values, and key relationships.
- Add a date dimension if the schema were extended beyond the small assignment sample.
- Document expected SQL outputs in a compact table for easier review.
- Keep the charts clearly labeled as sample-level visuals.

## Related Files

- [Project walkthrough](walkthrough/project-walkthrough.md)
- [Main SQL script](sql/pharmacy_claims_star_schema_queries.sql)
- [SQL notes](sql/README.md)
- [Data note](data/README.md)
- [Raw pharmacy claims sample](data/raw/final_project_data.csv)
- [Raw data description](data/raw/final_project_data_description.csv)
- [Member dimension CSV](data/processed/dim_member.csv)
- [Drug dimension CSV](data/processed/dim_drug.csv)
- [Prescription fact CSV](data/processed/fact_prescription.csv)
- [Outputs gallery](outputs/README.md)
- [ERD image](outputs/figures/04-erd-pharmacy-claims-star-schema.png)
- [Portfolio PDF](reports/aly6030-pharmacy-claims-portfolio.pdf)
- [Original course report](reports/cheng-liu-final-project-report.pdf)
- [Original ERD PDF](reports/cheng-liu-final-project-erd.pdf)
- [Assignment prompt](archive/final-project-instructions.pdf)
- [Contribution note](contribution-note.md)
