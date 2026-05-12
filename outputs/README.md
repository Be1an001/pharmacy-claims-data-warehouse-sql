# Outputs Gallery

This folder contains static screenshots and portfolio visuals for the SQL project. These files are evidence of the sample query outputs and schema design, not a deployed dashboard.

## Figure List

| File | What it shows |
|---|---|
| [`figures/01-sql-query-1-prescription-count-by-drug.png`](figures/01-sql-query-1-prescription-count-by-drug.png) | SQL output for prescription count by drug |
| [`figures/02-sql-query-2-member-age-group-analysis.png`](figures/02-sql-query-2-member-age-group-analysis.png) | SQL output for member age group summary |
| [`figures/03-sql-query-3-most-recent-fill-analysis.png`](figures/03-sql-query-3-most-recent-fill-analysis.png) | SQL output for most recent fill by member |
| [`figures/04-erd-pharmacy-claims-star-schema.png`](figures/04-erd-pharmacy-claims-star-schema.png) | ERD of the star schema |
| [`figures/05-chart-prescription-count-by-drug.png`](figures/05-chart-prescription-count-by-drug.png) | Static chart for prescription count by drug |
| [`figures/06-chart-insurance-paid-by-drug.png`](figures/06-chart-insurance-paid-by-drug.png) | Static chart for insurance-paid totals by drug |
| [`figures/07-chart-fill-timeline-by-member.png`](figures/07-chart-fill-timeline-by-member.png) | Static chart for fill timing by member |

## SQL Output Screenshots

The screenshots below show the outputs from the reporting queries in the main SQL script.

### Query 1 - Number of Prescriptions Grouped by Drug Name

![Query 1](figures/01-sql-query-1-prescription-count-by-drug.png)

### Query 2 - Member Age Group Analysis

![Query 2](figures/02-sql-query-2-member-age-group-analysis.png)

### Query 3 - Most Recent Prescription Fill Analysis

![Query 3](figures/03-sql-query-3-most-recent-fill-analysis.png)

## Schema Image

The ERD shows the small fact/dimension model used for the course sample.

![ERD](figures/04-erd-pharmacy-claims-star-schema.png)

## Portfolio Charts

The charts below make the sample outputs easier to scan. They should be interpreted carefully because the fact table contains only 11 fill-level rows.

### Prescription Count by Drug

![Prescription Count by Drug](figures/05-chart-prescription-count-by-drug.png)

### Insurance Paid by Drug

![Insurance Paid by Drug](figures/06-chart-insurance-paid-by-drug.png)

### Prescription Fill Timeline by Member

![Prescription Fill Timeline by Member](figures/07-chart-fill-timeline-by-member.png)

## Related Files

- [Project walkthrough](../walkthrough/project-walkthrough.md)
- [Main SQL script](../sql/pharmacy_claims_star_schema_queries.sql)
- [SQL notes](../sql/README.md)
- [Data note](../data/README.md)
- [Portfolio PDF](../reports/aly6030-pharmacy-claims-portfolio.pdf)
