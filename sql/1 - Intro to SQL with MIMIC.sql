/**
## Administrative and demographic data
We'll start by focusing on tables containing **administrative and demographic data**. These tables define general information about the patient or their hospitalizations. This includes data elements such as:
- Name
- Sex
- Date of birth
- Insurance information
- Admit/discharge datetime

Run the code below to run your first SQL query.
*/

SELECT *
FROM admissions
WHERE hadm_id <= '3033-07-08 00:00:00'
LIMIT 10;

/**

Let's go back through that SQL query. 
If we were to translate the query to natural language, we might express it as:

---
"Give me the top 10 rows of data from the `admissions` table 
where the admit datetime was before July 8th, 3033."
(Why do you think the dates look so weird?)

---

This returns 10 rows of data.

#### Discussion
What columns are returned by this query? What do the columns/values mean?

Here is the general structure of a SQL query:

- `SELECT`: This tells us which columns we want to pull. 
	If we say `SELECT *`, that means `"SELECT ALL COLUMNS"`
- `FROM`: This specifies which table the data will be in
- `JOIN`: This joins two tables together using a common key. 
	If we only need a single table, we can leave this out.
- `WHERE`: This allows to filter to where rows where a certain condition is matched
- `ORDER BY`: This sorts the rows by a particular column
- `LIMIT`: This means we only want the first `N` rows. 

Here's a slightly more complicated query:
*/


SELECT a.hadm_id, a.subject_id, 
    a.admittime, a.dischtime, 
    p.gender, p.dob, p.dod, p.expire_flag
FROM PATIENTS AS p
    INNER JOIN ADMISSIONS AS a
        ON p.subject_id = a.subject_id
WHERE dod <= dischtime
ORDER BY dod
LIMIT 10;

/**
TODO: Write an execute a query to select the following columns from ADMISSIONS:
	- hadm_id
    - subject_id
    - admittime
    - dischtime
*/


/**
## Joining tables
In a relational database like MIMIC, 
different attributes for entities are stored in different tables. 
These disparate tables can then be joined together in a query using a `join` statement. 
The column `subject_id`, which is the identifier for a patient, 
is consistent between these two columns and can be used to join them together:

---
FROM table1
    INNER JOIN table2
        ON table1.column = table2.column
---

#### TODO
Join the `ADMISSIONS` and `PRESCRIPTIONS` tables
using the `hadm_id` column in both as the joining keys. 
Select all columns and the **top 10** rows.

What do you think each row represents?
*/


/**
## Filtering results
Typically we don't want to return *all* rows from a table. 
We instead usually filter based on conditions related to the columns of the table. 
This is where the `WHERE` clause comes in.

For example, to get the demographic details for a single patient, 
we can filter based on the `subject_id` column:
*/
SELECT *
FROM ADMISSIONS
WHERE subject_id = 10017;

/**
If a column is in both tables that you've joined, you need to specify which table you're referring to. 

#### TODO
Run the query below and notice the error. How do you think you would fix it?
*/

SELECT *
FROM ADMISSIONS AS a
	INNER JOIN PATIENTS AS p 
    	ON a.subject_id = p.subject_id
WHERE subject_id = 10017;

/**
## Ordering results
Finally, we can order the queried data by using the `ORDER BY` clause:
*/
SELECT *
FROM PATIENTS
ORDER BY dob;

/**
We can also order by multiple columns:
*/
SELECT *
FROM PATIENTS
ORDER BY gender, dob;

/**
By default, `ORDER BY` sorts values in **ascending** order. But we can switch to **descending** order using the `DESC` keyword:

---
ORDER BY column DESC
---

#### TODO
Change the query above to sort the data by *date of death* in *descending* order. 
*/
SELECT *
FROM PATIENTS
;

/**
## Renaming columns
Sometimes we might want to rename our columns, maybe to make it a name that's easier to understand or that is less ambiguous. We do this the same way we assigned *aliases* to tables:

---
SELECT column1 AS new_name
    ,column2 new_name2 -- 'AS' is optional
---

#### TODO
Select the first 10 rows of subject_id, birth and death dates from `PATIENTS`. Rename `dob` to `date_of_birth` and `dod` to `date_of_death`. 
*/



/**
## Renaming columns
Sometimes we might want to rename our columns, maybe to make it a name that's easier to understand or that is less ambiguous. We do this the same way we assigned *aliases* to tables:

```sql
SELECT column1 AS new_name
    ,column2 new_name2 -- 'AS' is optional
```

#### TODO
Update the previous query to include age at the time of death by subtracting dob from dod. 
Name the new column `age_at_death`. What unit does this seem to be?
*/



/**
#### TODO
Write a query that calculates age at admission as well as age at death.
Exclude rows where the patient is recorded as being 300 when they died (I'm not sure, but I think that means the date of death is missing)
*/


