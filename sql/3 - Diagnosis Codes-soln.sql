/**
# 2. Diagnosis Data in MIMIC 
**Terminologies** are collections of concepts used to describe data. 
Each concept represents a single, unique item and has a unique identifier, also called a **code**. 
Medical data has terminologies to represent diagnoses, medications, and procedures. 
Furthermore, these terminologies are **standardized** so that they can be used across institutions 
	- the same concepts used to represent a disease in one healthcare system means the same thing in another.

One example of a terminology is the International Disease Classification (ICD) system. 
ICD codes are used to represent patient diagnoses and are used in healthcare systems across the world. 
There are a few different versions of the ICD system. 
In the US, ICD-9 codes were used until 2015, at which point ICD-10 became the main system. 
Since MIMIC-III data was generated before 2015, it uses ICD-9 codes to represent patient diagnoses.

The table `DIAGNOSES_ICD` contains the diagnoses assigned to patient hospitalizations. 
Here are the first 10 rows of `icd9`. 
A hospitalization can have one or more ICD-9 code and codes are ordered in importance by the `sequence` column.
*/

SELECT *
FROM DIAGNOSES_ICD
LIMIT 10;

/**
To see the names of these codes, we need to join the table of patient diagnoses with D_ICD_DIAGNOSES

#### TODO 
Join DIAGNOSES_ICD and D_ICD_DIAGNOSES. 
Select the first 100 subject id's, hospital admission id's, icd9 codes, and icd long titles. 
Name long_title `icd9_description`
*/
SELECT 
	dx.subject_id
    ,dx.hadm_id
    ,dx.icd9_code
    ,icd.long_title AS icd9_description
FROM DIAGNOSES_ICD dx 
	INNER JOIN D_ICD_DIAGNOSES icd 
    	ON dx.icd9_code = icd.icd9_code
LIMIT 100;

/**
#### TODO 
What are the 3 most common ICD-9 codes and descriptions?
*/

SELECT 
	dx.icd9_code
    ,icd.long_title AS icd9_description
    ,COUNT(1) n
FROM DIAGNOSES_ICD dx 
	INNER JOIN D_ICD_DIAGNOSES icd 
    	ON dx.icd9_code = icd.icd9_code
GROUP BY dx.icd9_code, icd.long_title
ORDER BY COUNT(1) DESC 
LIMIT 3
;

/**
## Creating patient cohorts 
Research projects typically create a dataset from a particular **patient cohort**,
which is defined some common attributes among a set of patients. 
This criterion will often include a particular diagnosis. 

For example, if we want to create a cohort of patients with diabetes, 
we could run a query like this to identify all hospitalizations with the code 
**250.00: Diabetes Mellitus w/o Complications Type II**:
*/
 SELECT *
FROM DIAGNOSES_ICD
WHERE icd9_code = '25000'
LIMIT 10       
 
 /**
 There are other codes for diabetes that we may want to include. 
 One way we can identify relevant codes is using the `LIKE` keyword. 
 The `LIKE` statement lets us do wildcard searches to match part of a text column, 
 where `'%'` is used to represent any character. So by replacing the `WHERE` clause above to `description LIKE '%diabetes%'`, 
 we can find all rows in the table whhere the description column contains "diabetes". 
 */
 
 SELECT *
 FROM D_ICD_DIAGNOSES icd 
 WHERE long_title LIKE '%diabetes%'
 
 /**
 #### TODO 
 Find the number of hospital admissions that have each ICD-9 code containing the word 'diabetes'. 
 Order the results by the count of hospital admissions in descending order. 
 */
 SELECT 
	dx.icd9_code
    ,icd.long_title AS icd9_description
    ,COUNT(1) n
FROM DIAGNOSES_ICD dx 
	INNER JOIN D_ICD_DIAGNOSES icd 
    	ON dx.icd9_code = icd.icd9_code
WHERE icd.long_title LIKE '%diabetes%'
GROUP BY dx.icd9_code, icd.long_title
ORDER BY COUNT(1) DESC 