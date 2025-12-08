-- COMPLETE MANUFACTURERS INSERTION SCRIPT (100 records)
-- Run this as a single script
SET DEFINE OFF;
BEGIN
    -- Insert 100 manufacturers in sequence
    INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date) 
    VALUES (seq_manufacturers.NEXTVAL, 'Pfizer Inc.', 'USA', 'info@pfizer.com', '+1-212-733-2323', 'Y', TO_DATE('2020-01-15', 'YYYY-MM-DD'));

    INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date) 
    VALUES (seq_manufacturers.NEXTVAL, 'Roche Holding AG', 'Switzerland', 'contact@roche.com', '+41-61-688-1111', 'Y', TO_DATE('2019-03-22', 'YYYY-MM-DD'));

    INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date) 
    VALUES (seq_manufacturers.NEXTVAL, 'Novartis AG', 'Switzerland', 'support@novartis.com', '+41-61-324-1111', 'Y', TO_DATE('2021-06-10', 'YYYY-MM-DD'));

    INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date) 
    VALUES (seq_manufacturers.NEXTVAL, 'Merck & Co.', 'USA', 'info@merck.com', '+1-908-423-1000', 'Y', TO_DATE('2020-11-05', 'YYYY-MM-DD'));

    INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date) 
    VALUES (seq_manufacturers.NEXTVAL, 'GlaxoSmithKline', 'UK', 'uk.info@gsk.com', '+44-20-8047-5000', 'Y', TO_DATE('2018-08-14', 'YYYY-MM-DD'));

    INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date) 
    VALUES (seq_manufacturers.NEXTVAL, 'Sanofi SA', 'France', 'contact@sanofi.com', '+33-1-53-77-40-00', 'Y', TO_DATE('2019-12-03', 'YYYY-MM-DD'));

    INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date) 
    VALUES (seq_manufacturers.NEXTVAL, 'AstraZeneca', 'UK', 'information@astrazeneca.com', '+44-20-3749-5000', 'Y', TO_DATE('2021-02-28', 'YYYY-MM-DD'));

    INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date) 
    VALUES (seq_manufacturers.NEXTVAL, 'Johnson & Johnson', 'USA', 'jjc@jnj.com', '+1-732-524-0400', 'Y', TO_DATE('2020-04-17', 'YYYY-MM-DD'));

    INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date) 
    VALUES (seq_manufacturers.NEXTVAL, 'Bayer AG', 'Germany', 'service@bayer.com', '+49-214-30-1', 'Y', TO_DATE('2019-09-25', 'YYYY-MM-DD'));

    INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date) 
    VALUES (seq_manufacturers.NEXTVAL, 'AbbVie Inc.', 'USA', 'abbvieinfo@abbvie.com', '+1-847-932-7900', 'Y', TO_DATE('2021-01-12', 'YYYY-MM-DD'));

    -- Next 40 manufacturers from various countries
    FOR i IN 1..40 LOOP
        INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date)
        VALUES (
            seq_manufacturers.NEXTVAL,
            CASE MOD(i, 8)
                WHEN 0 THEN 'PharmaCorp ' || CHR(65 + MOD(i, 26))
                WHEN 1 THEN 'MediTech Solutions ' || i
                WHEN 2 THEN 'BioPharm ' || CHR(65 + MOD(i, 26))
                WHEN 3 THEN 'Global Medicines ' || i
                WHEN 4 THEN 'Healthcare Ltd. ' || CHR(65 + MOD(i, 26))
                WHEN 5 THEN 'CureAll Pharmaceuticals'
                WHEN 6 THEN 'LifeSaver Meds'
                WHEN 7 THEN 'Wellness Pharma Inc.'
            END,
            CASE MOD(i, 10)
                WHEN 0 THEN 'USA' WHEN 1 THEN 'Germany' WHEN 2 THEN 'France'
                WHEN 3 THEN 'UK' WHEN 4 THEN 'Switzerland' WHEN 5 THEN 'Japan'
                WHEN 6 THEN 'India' WHEN 7 THEN 'China' WHEN 8 THEN 'Canada'
                WHEN 9 THEN 'Australia'
            END,
            'info' || i || '@pharma' || MOD(i, 5) || '.com',
            '+1-555-' || LPAD(1000 + i * 13, 4, '0'),
            CASE WHEN MOD(i, 20) = 0 THEN 'N' ELSE 'Y' END,
            TO_DATE('2020-01-01', 'YYYY-MM-DD') + TRUNC(DBMS_RANDOM.VALUE(0, 730))
        );
    END LOOP;

    -- Next 10 African manufacturers
    INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date) 
    VALUES (seq_manufacturers.NEXTVAL, 'Rwanda Pharma Ltd.', 'RWANDA', 'contact@rwandapharma.rw', '+250-788-123456', 'Y', TO_DATE('2022-03-15', 'YYYY-MM-DD'));

    INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date) 
    VALUES (seq_manufacturers.NEXTVAL, 'Kigali Medical Supplies', 'RWANDA', 'info@kigalimeds.rw', '+250-788-654321', 'Y', TO_DATE('2022-05-20', 'YYYY-MM-DD'));

    INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date) 
    VALUES (seq_manufacturers.NEXTVAL, 'East Africa Pharmaceuticals', 'KENYA', 'ea@eapharma.ke', '+254-722-111222', 'Y', TO_DATE('2021-11-30', 'YYYY-MM-DD'));

    INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date) 
    VALUES (seq_manufacturers.NEXTVAL, 'Kampala Drug Co.', 'UGANDA', 'sales@kampaladrug.ug', '+256-712-333444', 'Y', TO_DATE('2022-01-10', 'YYYY-MM-DD'));

    INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date) 
    VALUES (seq_manufacturers.NEXTVAL, 'Dar es Salaam Meds', 'TANZANIA', 'contact@darmeds.tz', '+255-765-555666', 'Y', TO_DATE('2021-09-22', 'YYYY-MM-DD'));

    INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date) 
    VALUES (seq_manufacturers.NEXTVAL, 'Addis Ababa Pharma', 'ETHIOPIA', 'info@addispharma.et', '+251-911-777888', 'Y', TO_DATE('2022-02-14', 'YYYY-MM-DD'));

    INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date) 
    VALUES (seq_manufacturers.NEXTVAL, 'Lagos Medical', 'NIGERIA', 'support@lagosmedical.ng', '+234-803-999000', 'Y', TO_DATE('2021-12-05', 'YYYY-MM-DD'));

    INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date) 
    VALUES (seq_manufacturers.NEXTVAL, 'Cairo Pharmaceuticals', 'EGYPT', 'contact@cairopharma.eg', '+20-2-1234567', 'Y', TO_DATE('2022-04-18', 'YYYY-MM-DD'));

    INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date) 
    VALUES (seq_manufacturers.NEXTVAL, 'Johannesburg Health', 'SOUTH AFRICA', 'info@joburghealth.co.za', '+27-11-9876543', 'Y', TO_DATE('2021-10-29', 'YYYY-MM-DD'));

    INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date) 
    VALUES (seq_manufacturers.NEXTVAL, 'Nairobi Drug Labs', 'KENYA', 'nairobi@druglabs.ke', '+254-733-444555', 'Y', TO_DATE('2022-06-11', 'YYYY-MM-DD'));

    -- Final 40 African manufacturers
    FOR i IN 1..40 LOOP
        INSERT INTO manufacturers (manufacturer_id, name, country, contact_email, phone, is_active, created_date)
        VALUES (
            seq_manufacturers.NEXTVAL,
            CASE MOD(i, 6)
                WHEN 0 THEN 'Medi ' || CHR(65 + MOD(i, 26)) || ' Rwanda'
                WHEN 1 THEN 'Health Solutions ' || CHR(65 + MOD(i, 26))
                WHEN 2 THEN 'Pharma Group ' || CHR(65 + MOD(i, 26))
                WHEN 3 THEN 'Care Providers Ltd.'
                WHEN 4 THEN 'Drug Manufacturing Co.'
                WHEN 5 THEN 'Medical Supplies Corp'
            END,
            CASE MOD(i, 8)
                WHEN 0 THEN 'RWANDA' WHEN 1 THEN 'KENYA' WHEN 2 THEN 'UGANDA'
                WHEN 3 THEN 'TANZANIA' WHEN 4 THEN 'ETHIOPIA' WHEN 5 THEN 'NIGERIA'
                WHEN 6 THEN 'GHANA' WHEN 7 THEN 'SOUTH AFRICA'
            END,
            'contact' || i || '@africapharma' || MOD(i, 3) || '.' || 
                CASE MOD(i, 8) 
                    WHEN 0 THEN 'rw' WHEN 1 THEN 'ke' WHEN 2 THEN 'ug' 
                    WHEN 3 THEN 'tz' WHEN 4 THEN 'et' WHEN 5 THEN 'ng' 
                    WHEN 6 THEN 'gh' WHEN 7 THEN 'co.za' 
                END,
            CASE MOD(i, 8)
                WHEN 0 THEN '+250-78' || LPAD(8000000 + i * 1111, 7, '0')
                WHEN 1 THEN '+254-7' || LPAD(2000000 + i * 2222, 8, '0')
                WHEN 2 THEN '+256-7' || LPAD(1000000 + i * 3333, 8, '0')
                WHEN 3 THEN '+255-7' || LPAD(6000000 + i * 4444, 8, '0')
                WHEN 4 THEN '+251-9' || LPAD(1000000 + i * 5555, 8, '0')
                WHEN 5 THEN '+234-80' || LPAD(3000000 + i * 6666, 7, '0')
                WHEN 6 THEN '+233-24' || LPAD(4000000 + i * 7777, 7, '0')
                WHEN 7 THEN '+27-11-' || LPAD(800 + i * 2, 4, '0')
            END,
            CASE WHEN MOD(i, 25) = 0 THEN 'N' ELSE 'Y' END,
            TO_DATE('2021-01-01', 'YYYY-MM-DD') + TRUNC(DBMS_RANDOM.VALUE(0, 730))
        );
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Successfully inserted 100 manufacturers.');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
        RAISE;
END;
/

-- Verify the data was inserted
SELECT COUNT(*) as total_manufacturers FROM manufacturers;

-- Show first 10 manufacturers
SELECT manufacturer_id, name, country, is_active 
FROM manufacturers 
WHERE ROWNUM <= 10 
ORDER BY manufacturer_id;

-- Show country distribution
SELECT country, COUNT(*) as count 
FROM manufacturers 
GROUP BY country 
ORDER BY count DESC;
