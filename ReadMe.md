# SQL Basics for Placements Revision

## Introduction to DBMS, DDL, DML
- **DBMS**: Stands for Database Management System. It's a software for managing databases.
- **DDL (Data Definition Language)**: Used to define the structure of the database.
  - **Commands**:
    - `CREATE`: Used to create tables.
    - `DROP`: Used to delete tables.
    - `ALTER`: Used to modify tables.
    - `TRUNCATE`: Used to remove all records from a table.
- **DML (Data Manipulation Language)**: Used to manage data within database objects.
  - **Commands**:
    - `INSERT`: Used to insert new records into a table.
    - `UPDATE`: Used to modify existing records in a table.
    - `DELETE`: Used to delete records from a table.

## Datatypes
- **Numeric**: Used for numeric data.
- **Date and Time**: Used for date and time values.
- **String**: Used for text data.

## Constraints
- **Unique**: Ensures that all values in a column are distinct.
- **Not Null**: Ensures that a column cannot have NULL values.
- **Default**: Provides a default value for a column.
- **Primary Key**: Uniquely identifies each record in a table.
- **Foreign Key**: Establishes a link between data in two tables.
- **Check**: Ensures that values in a column meet specific conditions.

## Operators
- **Arithmetic**: Perform mathematical operations.
- **Bitwise**: Perform operations at the bit level.
- **Comparison**: Compare values.
- **Logical**: Perform logical operations.

## DQL (Data Query Language)
- **Select query**: Retrieve data from one or more tables.
- **Group by**: Group rows based on specified criteria.
- **Order by**: Sort the result set.
- **Having by**: Filter groups based on specified conditions.

## In-built Functions
- **String Functions**: Manipulate string data.
- **Numeric Functions**: Perform calculations on numeric data.
- **Date & Time Functions**: Manipulate date and time values.

## Joins
- **Inner Join**: Returns records that have matching values in both tables.
- **Left Join**: Returns all records from the left table and the matched records from the right table.
- **Full Outer Join**: Returns all records when there is a match in either left or right table.
- **Cross Join**: Returns the Cartesian product of the two tables.
- **Self Join**: Joins a table with itself.

## Normalization
- **Anomalies**: Problems that occur when a database is not normalized.
- **Keys (Candidate Keys)**: Unique identifiers for rows in a table.
- **Primary Key and Foreign Key Constraint**: Enforces referential integrity.
- **1st, 2nd, 3rd Normal Form**: Progressive stages of normalization.
- **Boyce-Codd Normal Form**: A higher level of normalization.

## Subqueries
- **Single Row Subqueries**: Return only one row.
- **Multi Row Subqueries**: Return multiple rows.
- **Correlated Subqueries**: Dependent on the outer query.

## Analytics Functions / Advanced Functions
- **RANK, DENSE_RANK, ROW_NUMBER**: Rank rows based on specified criteria.
- **CUME_DIST**: Calculate cumulative distribution of a value.
- **LAG, LEAD**: Access data from a previous or subsequent row.

## Procedures, Functions, Cursors
- **Procedures**: Named blocks that perform one or more actions.
- **Functions**: Return a single value.
- **Cursors**: Allow traversal over the rows of a result set.

## TCL (Transaction Control Language) Commands
- **Commit, Rollback, Savepoint**: Manage transactions.

## Triggers
- **Introduction to Trigger**: A database object that automatically executes in response to certain events.
- **Insert, Update, and Delete Triggers**: Triggered by corresponding DML operations.

## View
- **Creating/Replacing Views**: Virtual tables that are based on the result of a SELECT query.
- **Dropping Views**: Deleting existing views.

