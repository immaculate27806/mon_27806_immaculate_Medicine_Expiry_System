-- SIMPLIFIED MEDICINES INSERTION SCRIPT
-- This script inserts 300 medicines without complex logic

BEGIN
    DBMS_OUTPUT.PUT_LINE('Starting medicine insertion...');
    
    -- Insert first 20 common medicines
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'Lipitor', 'Atorvastatin', 'TABLET', '20mg', 1, 'Y', 'Cholesterol', 'Room temperature', TO_DATE('2020-02-15', 'YYYY-MM-DD'));
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'Viagra', 'Sildenafil', 'TABLET', '50mg', 1, 'Y', 'Erectile Dysfunction', 'Room temperature', TO_DATE('2020-03-10', 'YYYY-MM-DD'));
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'Xanax', 'Alprazolam', 'TABLET', '0.5mg', 1, 'Y', 'Anxiety', 'Room temperature', TO_DATE('2020-04-22', 'YYYY-MM-DD'));
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'Tamiflu', 'Oseltamivir', 'CAPSULE', '75mg', 2, 'Y', 'Antiviral', 'Room temperature', TO_DATE('2020-05-14', 'YYYY-MM-DD'));
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'MabThera', 'Rituximab', 'INJECTION', '500mg', 2, 'Y', 'Oncology', 'Refrigerated 2-8°C', TO_DATE('2020-06-30', 'YYYY-MM-DD'));
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'Diovan', 'Valsartan', 'TABLET', '80mg', 3, 'Y', 'Hypertension', 'Room temperature', TO_DATE('2020-07-18', 'YYYY-MM-DD'));
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'Gleevec', 'Imatinib', 'TABLET', '400mg', 3, 'Y', 'Oncology', 'Room temperature', TO_DATE('2020-08-05', 'YYYY-MM-DD'));
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'Januvia', 'Sitagliptin', 'TABLET', '100mg', 4, 'Y', 'Diabetes', 'Room temperature', TO_DATE('2020-09-12', 'YYYY-MM-DD'));
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'Keytruda', 'Pembrolizumab', 'INJECTION', '100mg', 4, 'Y', 'Oncology', 'Refrigerated 2-8°C', TO_DATE('2020-10-25', 'YYYY-MM-DD'));
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'Advair', 'Fluticasone/Salmeterol', 'INHALER', '250/50mcg', 5, 'Y', 'Asthma', 'Room temperature', TO_DATE('2020-11-03', 'YYYY-MM-DD'));
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'Ventolin', 'Salbutamol', 'INHALER', '100mcg', 5, 'N', 'Asthma', 'Room temperature', TO_DATE('2020-12-19', 'YYYY-MM-DD'));
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'Paracetamol', 'Acetaminophen', 'TABLET', '500mg', 6, 'N', 'Pain Relief', 'Room temperature', TO_DATE('2021-01-10', 'YYYY-MM-DD'));
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'Ibuprofen', 'Ibuprofen', 'TABLET', '400mg', 7, 'N', 'Pain Relief', 'Room temperature', TO_DATE('2021-02-15', 'YYYY-MM-DD'));
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'Amoxicillin', 'Amoxicillin', 'CAPSULE', '500mg', 8, 'Y', 'Antibiotic', 'Room temperature', TO_DATE('2021-03-20', 'YYYY-MM-DD'));
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'Ciprofloxacin', 'Ciprofloxacin', 'TABLET', '500mg', 9, 'Y', 'Antibiotic', 'Room temperature', TO_DATE('2021-04-25', 'YYYY-MM-DD'));
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'Metformin', 'Metformin', 'TABLET', '850mg', 10, 'Y', 'Diabetes', 'Room temperature', TO_DATE('2021-05-30', 'YYYY-MM-DD'));
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'Lisinopril', 'Lisinopril', 'TABLET', '10mg', 11, 'Y', 'Hypertension', 'Room temperature', TO_DATE('2021-06-05', 'YYYY-MM-DD'));
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'Atorvastatin', 'Atorvastatin', 'TABLET', '40mg', 12, 'Y', 'Cholesterol', 'Room temperature', TO_DATE('2021-07-10', 'YYYY-MM-DD'));
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'Omeprazole', 'Omeprazole', 'CAPSULE', '20mg', 13, 'N', 'Acid Reflux', 'Room temperature', TO_DATE('2021-08-15', 'YYYY-MM-DD'));
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'Cetirizine', 'Cetirizine', 'TABLET', '10mg', 14, 'N', 'Allergy', 'Room temperature', TO_DATE('2021-09-20', 'YYYY-MM-DD'));
    INSERT INTO medicines VALUES (seq_medicines.NEXTVAL, 'Aspirin', 'Acetylsalicylic Acid', 'TABLET', '100mg', 15, 'N', 'Pain Relief', 'Room temperature', TO_DATE('2021-10-25', 'YYYY-MM-DD'));
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Inserted 21 common medicines');
    
    -- Insert 79 more simple medicines (total 100)
    FOR i IN 1..79 LOOP
        INSERT INTO medicines (
            medicine_id, brand_name, generic_name, form, strength, 
            manufacturer_id, requires_prescription, therapeutic_category, 
            storage_conditions, created_date
        ) VALUES (
            seq_medicines.NEXTVAL,
            'Medicine_' || i,
            'Generic_' || CHR(65 + MOD(i, 26)) || i,
            CASE MOD(i, 8)
                WHEN 0 THEN 'TABLET'
                WHEN 1 THEN 'SYRUP'
                WHEN 2 THEN 'INJECTION'
                WHEN 3 THEN 'CAPSULE'
                WHEN 4 THEN 'CREAM'
                WHEN 5 THEN 'OINTMENT'
                WHEN 6 THEN 'DROPS'
                WHEN 7 THEN 'INHALER'
            END,
            CASE MOD(i, 8)
                WHEN 0 THEN '100mg'
                WHEN 1 THEN '50mg/5ml'
                WHEN 2 THEN '200mg'
                WHEN 3 THEN '250mg'
                WHEN 4 THEN '1%'
                WHEN 5 THEN '2%'
                WHEN 6 THEN '0.5%'
                WHEN 7 THEN '150mcg'
            END,
            MOD(i, 100) + 1,  -- manufacturer_id between 1-100
            CASE WHEN MOD(i, 3) = 0 THEN 'N' ELSE 'Y' END,
            CASE MOD(i, 10)
                WHEN 0 THEN 'Antibiotic'
                WHEN 1 THEN 'Pain Relief'
                WHEN 2 THEN 'Hypertension'
                WHEN 3 THEN 'Diabetes'
                WHEN 4 THEN 'Allergy'
                WHEN 5 THEN 'Asthma'
                WHEN 6 THEN 'Cholesterol'
                WHEN 7 THEN 'Acid Reflux'
                WHEN 8 THEN 'Antiviral'
                WHEN 9 THEN 'Oncology'
            END,
            'Room temperature',
            TO_DATE('2021-01-01', 'YYYY-MM-DD') + i
        );
        
        IF MOD(i, 20) = 0 THEN
            DBMS_OUTPUT.PUT_LINE('  Processed ' || i || ' additional medicines...');
        END IF;
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Successfully inserted 100 medicines total.');
    
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate value error! Check primary key or unique constraints.');
        ROLLBACK;
        RAISE;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
        RAISE;
END;
/

SELECT COUNT(*) FROM medicines;