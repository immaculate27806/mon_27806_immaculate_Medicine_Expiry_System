-- Truncate batches table first
TRUNCATE TABLE batches;

-- Step 1: Insert one batch for each medicine (100 batches)
INSERT INTO batches (
    batch_id, medicine_id, batch_number, manufacture_date, expiry_date, 
    quantity_received, quantity_remaining, unit_price, supplier_name, 
    received_date, location, last_updated
)
SELECT
    ROWNUM,
    medicine_id,
    'BATCH' || LPAD(ROWNUM, 4, '0'),
    ADD_MONTHS(SYSDATE, -MOD(ROWNUM, 12) - 1),
    ADD_MONTHS(SYSDATE, MOD(ROWNUM, 24) + 12),
    100 + MOD(ROWNUM, 900),
    50 + MOD(ROWNUM, 850),
    10 + MOD(ROWNUM, 490) + (MOD(ROWNUM, 100)/100),
    CASE MOD(ROWNUM, 8)
        WHEN 0 THEN 'PharmaCorp'
        WHEN 1 THEN 'MediCare Ltd'
        WHEN 2 THEN 'BioGen'
        WHEN 3 THEN 'HealthPlus'
        WHEN 4 THEN 'Generic Pharma'
        WHEN 5 THEN 'Quality Meds'
        WHEN 6 THEN 'Trust Pharmacy'
        WHEN 7 THEN 'Prime Suppliers'
    END,
    ADD_MONTHS(SYSDATE, -MOD(ROWNUM, 6)),
    CASE MOD(ROWNUM, 4)
        WHEN 0 THEN 'Aisle A'
        WHEN 1 THEN 'Aisle B'
        WHEN 2 THEN 'Cold Storage'
        WHEN 3 THEN 'Shelf C'
    END || ' - Position ' || MOD(ROWNUM, 20),
    SYSDATE
FROM medicines;

-- Step 2: Insert 400 more batches with random medicine IDs
INSERT INTO batches (
    batch_id, medicine_id, batch_number, manufacture_date, expiry_date, 
    quantity_received, quantity_remaining, unit_price, supplier_name, 
    received_date, location, last_updated
)
SELECT
    100 + ROWNUM,
    (SELECT medicine_id FROM (
        SELECT medicine_id FROM medicines ORDER BY DBMS_RANDOM.VALUE
    ) WHERE ROWNUM = 1),
    'BATCH' || LPAD(100 + ROWNUM, 4, '0'),
    ADD_MONTHS(SYSDATE, -MOD(100 + ROWNUM, 12) - 1),
    ADD_MONTHS(SYSDATE, MOD(100 + ROWNUM, 24) + 12),
    100 + MOD(100 + ROWNUM, 900),
    50 + MOD(100 + ROWNUM, 850),
    10 + MOD(100 + ROWNUM, 490) + (MOD(100 + ROWNUM, 100)/100),
    CASE MOD(100 + ROWNUM, 8)
        WHEN 0 THEN 'PharmaCorp'
        WHEN 1 THEN 'MediCare Ltd'
        WHEN 2 THEN 'BioGen'
        WHEN 3 THEN 'HealthPlus'
        WHEN 4 THEN 'Generic Pharma'
        WHEN 5 THEN 'Quality Meds'
        WHEN 6 THEN 'Trust Pharmacy'
        WHEN 7 THEN 'Prime Suppliers'
    END,
    ADD_MONTHS(SYSDATE, -MOD(100 + ROWNUM, 6)),
    CASE MOD(100 + ROWNUM, 4)
        WHEN 0 THEN 'Aisle A'
        WHEN 1 THEN 'Aisle B'
        WHEN 2 THEN 'Cold Storage'
        WHEN 3 THEN 'Shelf C'
    END || ' - Position ' || MOD(100 + ROWNUM, 20),
    SYSDATE
FROM dual
CONNECT BY LEVEL <= 400;

COMMIT;