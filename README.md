# ⚡ PowerFlow: Marketing ROI Analytics with dbt & Snowflake

## A dbt Cloud project for modeling, cleaning, and analyzing marketing attribution data to calculate customer-level ROI

---

## 🧭 Project Overview

**PowerFlow** is an end-to-end analytics project built with **dbt Cloud** and **Snowflake**.  
It demonstrates how raw marketing and transaction data can be transformed into a clean, analytics-ready data model that enables reliable ROI calculations per customer.

The project simulates a multi-source marketing environment — combining user registration, campaign cost, transaction, and attribution data — to analyze how effectively marketing spend converts into revenue.

This implementation follows **modern data modeling best practices** with clearly separated layers for **staging**, **intermediate**, and **mart** models.  
All transformations are fully version-controlled via GitHub and orchestrated in dbt Cloud.

---

## 🧱 Architecture & Tech Stack

| Component | Purpose |
|------------|----------|
| **dbt Cloud** | Transformation and orchestration environment |
| **Snowflake** | Cloud data warehouse used as target database |
| **GitHub** | Version control for all dbt models and documentation |
| **dbt Packages** | `dbt_utils`, `codegen` for testing and documentation support |
| **CSV Seeds** | `campaign_cost.csv` used to bring static marketing spend data into the pipeline |

---

## 🔄 Data Flow & Model Layers

The data pipeline follows the **standard dbt layered architecture**:

```text
sources  →  staging  →  intermediate  →  marts
```

### 1️⃣ Sources

Raw input tables (e.g., from app tracking, Google Ads, and internal systems).  
They are defined in `_sources.yml` and stored in the Snowflake schema `powerflow.public`.

### 2️⃣ Staging Models (`stg_`)

Each source has a dedicated **staging model** to clean, rename, and standardize columns.  
This layer ensures consistent naming conventions and data formats across all sources.

| Model | Description |
|--------|--------------|
| `stg_appsflyer.sql` | Cleans app install and attribution data |
| `stg_google_ads.sql` | Normalizes campaign data from Google Ads |
| `stg_registrations_clean.sql` | Prepares user registration records |
| `stg_transactions.sql` | Standardizes transaction data for further aggregation |

All staging models are **materialized as views** for lightweight transformations.

### 3️⃣ Intermediate Models (`int_`)

These models combine and enrich data across multiple staging sources.  
They implement business logic such as user attribution, LTV calculations, and campaign mapping.

| Model | Description |
|--------|--------------|
| `int_marketing_attribution.sql` | Links each user to their originating marketing source |
| `int_users_with_attribution.sql` | Consolidates user registration with marketing data - adds organically acquired customers |
| `int_user_ltv.sql` | Calculates cumulative lifetime value (LTV) per user based on transactions |

### 4️⃣ Mart Models (`marts/`)

The **final data layer** used for business reporting and analytics.  
Models here are **materialized as tables** for performance and stability.

| Model | Description |
|--------|--------------|
| `user_roi.sql` | Combines user LTV with marketing spend to compute ROI per user |

---

## 💰 ROI Logic

The core output of this project is the **User ROI Table**.

**ROI Calculation:**

```sql
ROI = User_Lifetime_Revenue / Acquisition_Cost
```

For **organically acquired users**, acquisition cost is set to `0`.  
The model handles this gracefully (e.g., via `DIV0()` logic in Snowflake) to avoid division errors and maintain meaningful output.

The result allows comparing **paid vs. organic** acquisition performance, identifying which marketing channels deliver the highest return.

---

## 🧪 Testing & Data Quality

Data quality is ensured through a combination of **generic and custom dbt tests**:

| Type | Example |
|------|----------|
| **Generic Tests** | `unique`, `not_null`, `accepted_values` on keys and categorical columns |
| **Custom Test** | `positive_lifetime.sql` verifies that each user’s lifetime value is positive |
| **YAML Documentation** | `_schema_stg.yml`, `_schema_int.yml`, `_schema_roi.yml` describe columns and purposes |

All tests can be executed via:

```bash
dbt test
```

---

## 🧾 Seeds

The project includes one static seed:

- **`campaign_cost.csv`** – used to join campaign metadata and total cost information with attribution results.

Seeds are loaded via:

```bash
dbt seed
```

---

## ⚙️ Deployment & Orchestration

- The project is deployed in **dbt Cloud** with a connection to **Snowflake**.
- Branching and version control handled via **GitHub** (`main` and feature branches).
- **Environment-specific schemas**:  
  - `stg` for staging views  
  - `int` for intermediate views  
  - `marts` for final analytical table
- **Jobs in dbt Cloud** not scheduled (static training data) - manually triggered runs to build and test all models:

  ```bash
  dbt build --select +user_roi
  ```

---

## 📈 Example DAG

The resulting DAG (Directed Acyclic Graph) follows this simplified structure:

```bash
stg_appsflyer
stg_google_ads
stg_registrations_clean
stg_transactions
        ↓
int_marketing_attribution
int_users_with_attribution
int_user_ltv
        ↓
user_roi
```

---

## 💡 Key Learnings & Best Practices

Throughout this project, several **dbt best practices** were applied:

- ✅ Consistent naming conventions and clear folder structure  
- ✅ One staging model per source for transparency and reusability  
- ✅ Readable SQL (use of CTEs, aliases, and standardized formatting)  
- ✅ Documentation embedded in YAML for every model  
- ✅ Custom test for positive lifetime value validation  
- ✅ Separation of logic into layered models for maintainability

These improvements make the project easier to understand, extend, and present as a professional data transformation workflow.

---

## 🚀 Next Steps

Possible extensions include:

- Adding **channel-level ROI dashboards** in Tableau or Looker Studio  
- Implementing **incremental models** for faster runs on large datasets  
- Expanding attribution logic with **multi-touch models**  
- Integrating real campaign APIs (e.g., Google Ads, Meta) as sources  

---

## 👨‍💻 Author

**Thomas Jortzig**  
Powerflow-Project | 10.2025  
