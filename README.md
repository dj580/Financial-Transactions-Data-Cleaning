# Financial Transactions Data Cleaning

## Project Overview
This project focuses on cleaning and preparing a financial transactions dataset using **MySQL**, with **Excel used for documentation and validation**. The raw CSV data contained real-world data quality issues such as incorrect data types, currency symbols in numeric fields, mixed date formats, and invalid placeholder values.

The goal was to transform the raw dataset into a **clean, analysis-ready MySQL table** following best practices used in real-world analytics workflows.

---

## Tools Used
- MySQL (data cleaning, transformation, validation)
- MS Excel (cleaning log, before/after comparison, documentation)

---

## Data Issues Identified
- All columns imported as VARCHAR
- Currency symbols (`$`, `$-`) and commas in numeric fields
- Invalid numeric placeholders (`-`, blanks)
- Mixed date formats (`DD-MM-YYYY`, `MM/DD/YYYY`)
- Extra spaces and inconsistent text formatting

---

## Cleaning Steps Performed (MySQL)
- Trimmed text fields and standardized casing
- Removed currency symbols, commas, and invalid characters from numeric columns
- Converted numeric fields to appropriate DECIMAL data types
- Standardized mixed date formats into DATE type
- Converted month and year fields to integers
- Handled MySQL strict-mode casting errors explicitly
- Created a clean table: `transactions_clean`

---

## Final Output
- A fully cleaned and schema-correct MySQL table ready for analysis
- Documented cleaning process using an Excel cleaning log
- Validated data using row counts, range checks, and aggregate checks

---

## Key Learnings
- Import raw data safely before applying strict data types
- Normalize data before validation and casting
- Handle strict SQL mode explicitly to avoid silent data loss
- Let actual data drive schema decisions
- Document all cleaning steps for transparency and reproducibility

---

## Author
**David Jose**  
Aspiring Data Analyst  

---


