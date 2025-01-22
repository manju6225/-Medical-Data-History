-- 1. Show first name, last name, and gender of patients whose gender is 'M'
SELECT first_name, last_name, gender
FROM patients
WHERE gender = 'M'
LIMIT 1000;

-- 2. Show first name and last name of patients who do not have allergies
SELECT first_name, last_name
FROM patients
WHERE allergies IS NULL
LIMIT 1000;

-- 3. Show first name of patients that start with the letter 'C'
SELECT first_name
FROM patients
WHERE first_name LIKE 'C%'
LIMIT 1000;

-- 4. Show first name and last name of patients that weight within 100 to 120
SELECT first_name, last_name
FROM patients
WHERE weight BETWEEN 100 AND 120
LIMIT 1000;

-- 5. Show what allergies would be if updated to 'NKA' (read-only version)
SELECT 
    first_name,
    last_name,
    CASE 
        WHEN allergies IS NULL THEN 'NKA'
        ELSE allergies 
    END as allergies
FROM patients
LIMIT 1000;

-- 6. Concatenate first name and last name
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM patients
LIMIT 1000;

-- 7. Show patient names with full province name
SELECT p.first_name, p.last_name, province_id
FROM patients p
LIMIT 1000;

-- 8. Count patients born in 2010
SELECT COUNT(*) as patients_2010
FROM patients
WHERE YEAR(birth_date) = 2010;

-- 9. Patient with greatest height
SELECT first_name, last_name, height
FROM patients
WHERE height = (SELECT MAX(height) FROM patients);

-- 10. Show patients with specific IDs
SELECT *
FROM patients
WHERE patient_id IN (1, 45, 534, 879, 1000);

-- 11. Total number of admissions
SELECT COUNT(*) as total_admissions
FROM admissions;

-- 12. Same day admissions and discharges
SELECT *
FROM admissions
WHERE admission_date = discharge_date
LIMIT 1000;

-- 13. Admissions for patient 579
SELECT COUNT(*) as admission_count
FROM admissions
WHERE patient_id = 579;

-- 14. Unique cities in NS province
SELECT DISTINCT city
FROM patients
WHERE province_id = 'NS'
LIMIT 1000;

-- 15. Patients with height > 160 and weight > 70
SELECT first_name, last_name, birth_date
FROM patients
WHERE height > 160 AND weight > 70
LIMIT 1000;

-- 16. Unique birth years ordered ascending
SELECT DISTINCT YEAR(birth_date) as birth_year
FROM patients
ORDER BY birth_year ASC;

-- 17. First names that occur only once
SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(*) = 1
LIMIT 1000;

-- 18. Names starting and ending with 's'
SELECT patient_id, first_name
FROM patients
WHERE first_name LIKE 's%s'
AND LENGTH(first_name) >= 6
LIMIT 1000;

-- 19. Patients diagnosed with Dementia
SELECT p.patient_id, p.first_name, p.last_name
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
WHERE a.diagnosis = 'Dementia'
LIMIT 1000;

-- 20. Names ordered by length and alphabetically
SELECT first_name
FROM patients
ORDER BY LENGTH(first_name), first_name
LIMIT 1000;

-- 21. Count of male and female patients
SELECT 
    SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) as male_count,
    SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) as female_count
FROM patients;

-- 23. Patients with multiple admissions for same diagnosis
SELECT patient_id, diagnosis, COUNT(*) as diagnosis_count
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1
LIMIT 1000;

-- 24. Patient count by city
SELECT city, COUNT(*) as patient_count
FROM patients
GROUP BY city
ORDER BY patient_count DESC, city ASC
LIMIT 1000;

-- 25. List of patients and doctors
SELECT first_name, last_name, 'Patient' as role
FROM patients
UNION
SELECT first_name, last_name, 'Doctor' as role
FROM doctors
LIMIT 1000;

-- 26. Allergies by popularity
SELECT allergies, COUNT(*) as allergy_count
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY allergy_count DESC
LIMIT 1000;

-- 27. Patients born in 1970s
SELECT first_name, last_name, birth_date
FROM patients
WHERE YEAR(birth_date) BETWEEN 1970 AND 1979
ORDER BY birth_date
LIMIT 1000;

-- 28. Full name formatting
SELECT CONCAT(UPPER(last_name), ',', LOWER(first_name)) as full_name
FROM patients
ORDER BY first_name DESC
LIMIT 1000;

-- 29. Province heights >= 7000
SELECT province_id, SUM(height) as total_height
FROM patients
GROUP BY province_id
HAVING SUM(height) >= 7000;

-- 30. Weight difference for Maroni
SELECT MAX(weight) - MIN(weight) as weight_difference
FROM patients
WHERE last_name = 'Maroni';

-- 31. Admissions by day of month
SELECT DAY(admission_date) as day_of_month,
       COUNT(*) as admission_count
FROM admissions
GROUP BY day_of_month
ORDER BY admission_count DESC;

-- 32. Patients by weight groups
SELECT 
    FLOOR(weight/10)*10 as weight_group,
    COUNT(*) as patient_count
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;

-- 33. Obesity calculation
SELECT 
    patient_id, 
    weight, 
    height,
    CASE 
        WHEN (weight/POWER(height/100.0, 2)) >= 30 THEN 1 
        ELSE 0 
    END as isObese
FROM patients
LIMIT 1000;

-- 34. Epilepsy patients with Dr. Lisa
SELECT p.patient_id, p.first_name, p.last_name, 'Doctor Specialty' as specialty
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
WHERE a.diagnosis = 'Epilepsy'
LIMIT 1000;

-- 35. Temporary password generation
SELECT 
    p.patient_id,
    CONCAT(p.patient_id, LENGTH(p.last_name), YEAR(p.birth_date)) as temp_password
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
GROUP BY p.patient_id
LIMIT 1000;

-- 36. View table structures
SHOW TABLES;

-- Check specific table structures
DESCRIBE patients;
DESCRIBE admissions;

-- Sample data from main tables
SELECT * FROM patients LIMIT 5;
SELECT * FROM admissions LIMIT 5;