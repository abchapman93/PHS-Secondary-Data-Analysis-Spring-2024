/**
So far, everything we've done with SQL has been at the **row-level**. That is, we've written queries that have returned results with a single entity (patient, hospitalization, etc.) per row. Next we'll start looking at how to **aggregate** data in SQL.

Some examples of aggregate data we coud compute in MIMIC include:
- The number of admissions
- The count of patients by sex
- The min and max admission date for patients
- The mean/min/max/standard deviation of length of stay

In `module_2`, we learned how to do many of these calculatins in Python using `pandas`. Aggregating data in SQL is very similar. Each of the calculations described above can be computed using a **SQL function** like `COUNT()`, `MIN()`, or `MAX()`.

### Counts
One of the most basic aggegations is simply counting the number of rows in a table. We can get this by selecting `COUNT(*)` or `COUNT(1)`:
*/
SELECT COUNT(1) AS n_patients
FROM PATIENTS;

/**
#### TODO
Count the number of admissions. Name it n_admissions 
*/
SELECT COUNT(*) AS n_admissions
FROM ADMISSIONS;

/**
Aggregate queries can have other clauses like `WHERE`, `JOIN`, etc., so you can filter and join the data you're counting.

#### TODO
How many rows in the table `ADMISSIONS` represent an admission from the emergency room?
*/

SELECT COUNT(1)
FROM ADMISSIONS 
where admission_type = 'EMERGENCY'
;

/**
### Mins, Maxes, and Means
SQL has functions to calculate extreme values, and means. 
For example, the query below calculates the earliest/latest dates of birth and death:
*/

SELECT 
    MIN(dob) earliest_birth, MAX(dob) latest_birth, 
    MIN(dod) earliest_death, MAX(dod) latest_death,
    MIN(dod - dob) youngest_death, MAX(dod-dob) oldest_death,
    AVG(dod-dob) mean_death
FROM PATIENTS p

/**
The queries above gave us single aggregate stats over an entire set of patients. But we might want to break our statistics up into groups. We'll use the `GROUP BY` clause for that. 

The `GROUP BY` clause tells us which column to use for breaking our patients up into groups. This works just like `df.groupby` in pandas. 

The query below counts the number of patients by `sex`:
*/
SELECT gender, COUNT(1) n_patients
FROM PATIENTS 
GROUP BY gender
ORDER BY COUNT(1);

/**
#### TODO 
Count the number of hospital admissions by admit type. 
Order the results from most to least frequent. 
*/
SELECT admission_type, COUNT(1)
FROM ADMISSIONS 
GROUP BY admission_type
ORDER BY COUNT(1) desc;

/**
We can also group by multiple columns at once. 
The query below counts the number of admissions by admission_type and whether they died in the hospital. 
*/
SELECT admission_type, hospital_expire_flag, COUNT(1)
FROM ADMISSIONS
GROUP BY admission_type, hospital_expire_flag
ORDER BY admission_type, hospital_expire_flag;

/**
#### TODO 
Get the count of the number of admissions by gender and ethnicity. 
*/
SELECT 
	gender, 
    ethnicity,
    COUNT(1)
FROM PATIENTS p 
	INNER JOIN ADMISSIONS a 
    	ON p.subject_id = a.subject_id
GROUP BY gender, ethnicity
ORDER BY gender, ethnicity;
