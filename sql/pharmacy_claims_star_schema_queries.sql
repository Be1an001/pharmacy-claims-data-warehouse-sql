-- ========================================
-- PHARMACY CLAIMS STAR SCHEMA + REPORTING
-- Cheng Liu
-- ALY6030 Final Project
-- ========================================

-- ========================================
-- PART 2: DATABASE, TABLE CREATION, KEY SETUP, AND DATA INSERTION
-- ========================================

CREATE DATABASE IF NOT EXISTS assignment6_db;
USE assignment6_db;

DROP TABLE IF EXISTS fact_prescription;
DROP TABLE IF EXISTS dim_member;
DROP TABLE IF EXISTS dim_drug;

CREATE TABLE dim_member (
    member_id INT NOT NULL COMMENT 'Member unique identifier from PBM. Natural Key.',
    member_first_name VARCHAR(100),
    member_last_name VARCHAR(100),
    member_birth_date DATE COMMENT 'Member birth date.',
    member_gender CHAR(1) COMMENT 'Member gender (for example M or F).',
    PRIMARY KEY (member_id)
) COMMENT = 'Dimension table for member information. PK: member_id (Natural Key).';

CREATE TABLE dim_drug (
    drug_ndc INT NOT NULL COMMENT 'National Drug Code. Natural Key.',
    drug_name VARCHAR(100) COMMENT 'Drug name.',
    drug_form_code CHAR(2) COMMENT 'Drug form code.',
    drug_form_desc VARCHAR(100) COMMENT 'Drug form description.',
    drug_brand_generic_code INT COMMENT 'Brand or generic code.',
    drug_brand_generic_desc VARCHAR(10) COMMENT 'Brand or generic description.',
    PRIMARY KEY (drug_ndc)
) COMMENT = 'Dimension table for drug information. PK: drug_ndc (Natural Key).';

CREATE TABLE fact_prescription (
    fill_id INT AUTO_INCREMENT NOT NULL COMMENT 'Surrogate key for each prescription fill event.',
    member_id INT NOT NULL COMMENT 'Foreign key to dim_member.member_id.',
    drug_ndc INT NOT NULL COMMENT 'Foreign key to dim_drug.drug_ndc.',
    fill_date DATE NOT NULL COMMENT 'Date the prescription was filled.',
    copay DECIMAL(10, 2) COMMENT 'Amount paid by the member.',
    insurance_paid DECIMAL(10, 2) COMMENT 'Amount paid by insurance.',
    PRIMARY KEY (fill_id)
) COMMENT = 'Fact table for prescription fill events. PK: fill_id (Surrogate Key).';

INSERT INTO dim_member (member_id, member_first_name, member_last_name, member_birth_date, member_gender) VALUES
(10001, 'David ', 'Dennison', STR_TO_DATE('6/14/1946', '%m/%d/%Y'), 'M'),
(10002, 'John', 'Smith', STR_TO_DATE('1/2/1962', '%m/%d/%Y'), 'M'),
(10003, 'Jane', 'Doe', STR_TO_DATE('5/4/1982', '%m/%d/%Y'), 'F'),
(10004, 'Elaine', 'Rogers', STR_TO_DATE('10/12/1983', '%m/%d/%Y'), 'F');

INSERT INTO dim_drug (drug_ndc, drug_name, drug_form_code, drug_form_desc, drug_brand_generic_code, drug_brand_generic_desc) VALUES
(433530848, 'Risperidone', 'TB', 'Tablet', 1, 'Generic'),
(545695193, 'Amoxicillin', 'OS', 'Oral Solution', 1, 'Generic'),
(545693828, 'Ambien', 'TB', 'Tablet', 2, 'Brand'),
(185085302, 'Diprosone  ', 'TC', 'Topical Cream', 1, 'Generic');

INSERT INTO fact_prescription (member_id, drug_ndc, fill_date, copay, insurance_paid) VALUES
(10001, 433530848, STR_TO_DATE('10/31/2017', '%m/%d/%Y'), 15.00, 50.00),
(10001, 433530848, STR_TO_DATE('2/22/2018', '%m/%d/%Y'), 15.00, 48.00),
(10001, 433530848, STR_TO_DATE('5/8/2018', '%m/%d/%Y'), 15.00, 55.00),
(10002, 545695193, STR_TO_DATE('6/14/2018', '%m/%d/%Y'), 50.00, 130.00),
(10003, 545693828, STR_TO_DATE('12/30/2017', '%m/%d/%Y'), 35.00, 250.00),
(10003, 545693828, STR_TO_DATE('5/16/2018', '%m/%d/%Y'), 35.00, 322.00),
(10004, 185085302, STR_TO_DATE('11/9/2017', '%m/%d/%Y'), 15.00, 600.00),
(10004, 185085302, STR_TO_DATE('12/8/2017', '%m/%d/%Y'), 15.00, 712.00),
(10001, 545693828, STR_TO_DATE('1/15/2018', '%m/%d/%Y'), 20.00, 650.00),
(10001, 545693828, STR_TO_DATE('2/14/2018', '%m/%d/%Y'), 20.00, 648.00),
(10001, 545693828, STR_TO_DATE('3/13/2018', '%m/%d/%Y'), 20.00, 648.00);

ALTER TABLE fact_prescription
ADD CONSTRAINT fk_fact_prescription_member
    FOREIGN KEY (member_id)
    REFERENCES dim_member(member_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
ADD CONSTRAINT fk_fact_prescription_drug
    FOREIGN KEY (drug_ndc)
    REFERENCES dim_drug(drug_ndc)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

SELECT * FROM dim_member;
SELECT * FROM dim_drug;
SELECT * FROM fact_prescription;

-- ========================================
-- PART 4: ANALYTICS AND REPORTING
-- ========================================

-- QUERY 1: NUMBER OF PRESCRIPTIONS BY DRUG
SELECT
    d.drug_name,
    COUNT(f.fill_id) AS number_of_prescriptions
FROM
    fact_prescription f
INNER JOIN
    dim_drug d ON f.drug_ndc = d.drug_ndc
GROUP BY
    d.drug_name
ORDER BY
    number_of_prescriptions DESC;

-- QUERY 2: MEMBER AGE GROUP ANALYSIS
-- fixed as-of date used here to keep the portfolio results stable
SELECT
    CASE
        WHEN TIMESTAMPDIFF(YEAR, m.member_birth_date, '2026-04-05') >= 65 THEN 'age 65+'
        ELSE '< 65'
    END AS age_group,
    COUNT(f.fill_id) AS total_prescriptions,
    COUNT(DISTINCT f.member_id) AS unique_members,
    SUM(f.copay) AS total_copay,
    SUM(f.insurance_paid) AS total_insurance_paid
FROM
    fact_prescription f
INNER JOIN
    dim_member m ON f.member_id = m.member_id
GROUP BY
    age_group
ORDER BY
    age_group;

-- QUERY 3: MOST RECENT PRESCRIPTION FILL ANALYSIS
-- this query uses a CTE and ROW_NUMBER(), so it assumes MySQL 8+
WITH RankedFills AS (
    SELECT
        f.member_id,
        m.member_first_name,
        m.member_last_name,
        d.drug_name,
        f.fill_date,
        f.insurance_paid,
        ROW_NUMBER() OVER (PARTITION BY f.member_id ORDER BY f.fill_date DESC) AS rn
    FROM
        fact_prescription f
    INNER JOIN
        dim_member m ON f.member_id = m.member_id
    INNER JOIN
        dim_drug d ON f.drug_ndc = d.drug_ndc
)
SELECT
    member_id,
    member_first_name,
    member_last_name,
    drug_name,
    fill_date AS most_recent_fill_date,
    insurance_paid AS most_recent_insurance_paid
FROM
    RankedFills
WHERE
    rn = 1
ORDER BY
    member_id;
