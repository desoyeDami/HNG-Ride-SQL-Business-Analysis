# HNG Ride - SQL Business Analysis (Stage 2A)

This project is a comprehensive analysis of a raw, inconsistent dataset from a fictional ride-sharing company, HNG Ride. The primary goal was to perform a complete data cleaning and preparation process using SQL and Python, then answer 8 critical business questions using advanced SQL queries to provide actionable insights for management.

This project was completed as part of the HNG Internship.

## 🚀 Tech Stack
* **SQL (SQLite):** Used for all data cleaning, transformation, and analysis.
* **Python:** Used for initial data loading (`pandas`) and database connection.
* **Jupyter Notebook:** The environment for running all data cleaning and analysis.
* **`jupysql`:** Used to run SQL queries directly within the Jupyter Notebook.

## 🧹 Data Cleaning & Preparation
The raw CSV data (rides, drivers, riders, payments) was ingested into a SQLite database. Before analysis, the following cleaning steps were performed:

* **Date Conversion:** Parsed and converted non-standard text dates (e.g., 'M/D/YYYY H:MM') into a standard, queryable `YYYY-MM-DD HH:MM:SS` format for all date-related columns.
* **Invalid Data Removal:** Deleted 653 rides with negative or zero fares and 10,582 payment records with zero-dollar amounts to isolate valid, completed transactions.
* **Text Standardization:** Corrected inconsistent text entries in the `status` column (e.g., "complted" to "completed").

## 📈 Business Questions Answered
The analysis focused on answering 8 key business questions:

1.  Find the **top 10 longest rides** (by distance), including driver/rider names and payment method.
2.  Identify how many **riders who signed up in 2021** took a ride in 2024.
3.  Determine the quarter with the **biggest Year-over-Year (YoY) revenue growth**.
4.  Find the **top 5 most consistent drivers** (highest average rides per active month).
5.  Calculate the cancellation rate per city and identify the **city with the highest rate**.
6.  Identify **riders with >10 rides who have never paid with cash**.
7.  Find the **top 3 drivers by total revenue in each city** using window functions.
8.  Identify the **top 10 drivers qualified for a bonus** based on a 3-part criteria ( $\ge$ 30 completed rides, $\ge$ 4.5 rating, and < 5% cancellation rate).

## 🗂 Files in this Repository
* `hng_ride.ipynb`: Jupyter Notebook containing the initial data ingestion and cleaning steps (e.g., `pandas` to SQLite, date conversions, deleting invalid rows).
* `sql1.ipynb`: Jupyter Notebook containing the final 8 SQL queries and their results.
* `report.pdf`: A business report summarizing the objective, process, and findings.
* `1.sql` - `8.sql`: Individual `.sql` files for each business question.
* `hng_ride.db`: The final, cleaned SQLite database.
* `*.csv`: The original raw data files.

## 💡 Key Findings
* **Top Bonus Drivers:** Only two drivers (**Driver_1005** and **Driver_1181**) met the strict criteria for the performance bonus.
* **Highest Cancellation:** **Chicago** had the highest ride cancellation rate at **19.27%**.
* **Top Growth:** **Q4 2024** showed the strongest Year-over-Year revenue growth at **4.04%**.
* **Loyal Customers:** **2,051 riders** from the 2021 sign-up cohort were still active in 2024.

---
