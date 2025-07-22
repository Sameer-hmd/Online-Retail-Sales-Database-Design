# Online-Retail-Sales-Database-Design
# 🛒 Online Retail Sales Database Design

## 📌 Objective

Design and implement a fully normalized Oracle SQL database for an online retail platform that manages customers, products, orders, payments, and shipping. The project emphasizes data integrity, scalability, and real-world e-commerce workflows.

---

## 🗂️ Project Files

| File Name                 | Description                                                                             |
|--------------------------|-----------------------------------------------------------------------------------------|
| `README.md`              | Full documentation (objective, schema, ERD, queries, instructions).                     |
| `ERD.png`                | Entity Relationship Diagram of the database.                                            |
| `create_tables.sql`      | DDL script to create all normalized tables with constraints.                            |
| `insert_sample_data.sql` | Inserts 100–200 rows of realistic dummy data.                                           |
| `query_reports.sql`      | Advanced queries: JOINs, GROUP BY, analytics (e.g., total sales per product, customer). |
| `views.sql`              | SQL views for sales summary, customer insights, product catalog.                        |
| `indexes_constraints.sql`| Indexes and foreign key constraints separately if needed.                               |

---

## 🧩 Schema Overview

The database schema is fully normalized to **Third Normal Form (3NF)**, ensuring minimal redundancy and high data integrity. It includes the following key entities:

| Table Name    | Description                                |
|---------------|--------------------------------------------|
| `Customers`   | Stores customer personal and contact details. |
| `Products`    | Stores information about products available for sale. |
| `Categories`  | Classifies products (e.g., Electronics, Apparel). |
| `Orders`      | Records customer orders with timestamps and status. |
| `Order_Items` | Details line items per order (product, quantity, price). |
| `Payments`    | Stores payment information related to each order. |
| `Shipping`    | Tracks shipping addresses and delivery status. |

---

## 🔗 Table Relationships

- **Customers → Orders**: One-to-many  
- **Orders → Order_Items**: One-to-many  
- **Products → Order_Items**: One-to-many  
- **Products → Categories**: Many-to-one  
- **Orders → Payments**: One-to-one  
- **Orders → Shipping**: One-to-one  

Refer to the `ERD.png` file for a visual representation.

---

## 📊 Key Features

- Normalized schema (3NF)
- Foreign keys, NOT NULL, UNIQUE, CHECK constraints
- Realistic sample data for testing (100–200 rows)
- Indexed key fields for performance
- Views for customer order history, product sales, and shipping
- Query reports for:
  - Top-selling products
  - Monthly revenue
  - Orders per customer
  - Pending payments or shipments

---

## 🚀 How to Use

1. Open the project in an Oracle SQL environment (e.g., Oracle SQL Developer or SQL*Plus).
2. Run `create_tables.sql` to create all tables.
3. Execute `insert_sample_data.sql` to populate the tables.
4. Use `views.sql` to create summary views.
5. Execute `query_reports.sql` to explore advanced analytics.
6. Optionally run `indexes_constraints.sql` to apply additional constraints and performance tuning.

---

## 📎 Tools Used

- **Oracle SQL**
- **SQL Developer** (recommended IDE)
- **Draw.io / Lucidchart** (for ERD design)

---

## 📚 Description 

Designed a normalized Oracle SQL database for an online retail system covering customers, products, orders, payments, and shipping. Includes ERD, realistic sample data, complex queries, and views for sales insights. Supports reporting on top products, monthly revenue, and customer activity.

---
