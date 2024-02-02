# Data Management and Visualization Project: Reddit

## Overview
This repository contains the collaborative efforts of our team in implementing a comprehensive data management and visualization project. As part of the assignment, we've constructed both the logical and physical models, implemented a SQL Server database, generated test data, and developed essential procedures and triggers. Additionally, we've created an Online Analytical Processing (OLAP) environment using MicroStrategy, showcasing visualizations based on the transactional system.

## Repository Structure
1. Data Files: `/faked_data.xlsx`: Excel file containing data that we invented.
2. Database Models: `/db_models`: Images of logical and physical database models, and also the data warehouse model.
3. SQL Files: `/sql`: SQL files with Data Definition Language (DDL) statements for database creation, stored procedures representing key database operations and trigger implementations for important events.
4. Visualization: `/visualizations`: Files with MicroStrategy-generated visualizations.

## Getting Started
### Database Implementation:
1. Execute the DDL scripts in `/sql` in your SQL Server database. Correct any issues encountered during the execution.
2. Import data faked_data.xlsx to populate the tables. Ensure at least 1000 records for transaction tables and 30 records for other tables.

### Stored Procedures and Triggers
1. Run the SQL scripts to implement essential procedures for database operations and triggers for key events.
2. You could then try to run different operations to check them.

### MicroStrategy OLAP Environment:
1. Utilize MicroStrategy to generate an OLAP environment based on the implemented transactional system.
2. Refer to /visualizations for the MicroStrategy-generated file.

## Contributors
- Dominguez, Manuel
- Jons, Maica
- Mindiuk, Dana
- Waisburg, Ariel
