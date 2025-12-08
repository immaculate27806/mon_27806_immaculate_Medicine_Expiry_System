-- COMPLETE CLEANUP AND POPULATION SCRIPT
-- Run this entire script to start fresh

-- Step 1: Disable foreign key constraints (for related tables)
BEGIN
    -- Disable alerts foreign key first (since it references batches)
    BEGIN
        EXECUTE IMMEDIATE 'ALTER TABLE alerts DISABLE CONSTRAINT fk_alert_batch';
        DBMS_OUTPUT.PUT_LINE('Disabled alerts foreign key constraint');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Could not disable alerts constraint: ' || SQLERRM);
    END;
    
    -- Disable batches foreign key
    BEGIN
        EXECUTE IMMEDIATE 'ALTER TABLE batches DISABLE CONSTRAINT fk_batch_medicine';
        DBMS_OUTPUT.PUT_LINE('Disabled batches foreign key constraint');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Could not disable batches constraint: ' || SQLERRM);
    END;
END;
/

-- Step 2: Delete all existing data
BEGIN
    -- Delete from alerts first (child table)
    EXECUTE IMMEDIATE 'DELETE FROM alerts';
    DBMS_OUTPUT.PUT_LINE('Deleted all alerts');
    
    -- Delete from batches
    EXECUTE IMMEDIATE 'DELETE FROM batches';
    DBMS_OUTPUT.PUT_LINE('Deleted all batches');
    
    COMMIT;
END;
/

-- Step 3: Reset sequence
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE seq_batches';
    DBMS_OUTPUT.PUT_LINE('Dropped sequence seq_batches');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Sequence did not exist or could not be dropped: ' || SQLERRM);
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE SEQUENCE seq_batches START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE';
    DBMS_OUTPUT.PUT_LINE('Created new sequence seq_batches');
END;
/

-- Step 4: Insert 500 fresh batches
DECLARE
    v_counter NUMBER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Starting to insert 500 batches...');
    
    WHILE v_counter <= 500 LOOP
        INSERT INTO batches (
            batch_id, medicine_id, batch_number, manufacture_date, 
            expiry_date, quantity_received, quantity_remaining,
            unit_price, supplier_name, received_date, location, last_updated
        ) VALUES (
            seq_batches.NEXTVAL,
            -- medicine_id between 1-100 (assuming you have 100 medicines)
            TRUNC(DBMS_RANDOM.VALUE(1, 101)),
            -- UNIQUE batch number format: BATCH-000001, BATCH-000002, etc.
            'BATCH-' || LPAD(seq_batches.CURRVAL, 6, '0'),
            -- Manufacture date: 100-500 days ago
            TRUNC(SYSDATE) - TRUNC(DBMS_RANDOM.VALUE(100, 501)),
            -- Expiry date: 30-730 days from now
            TRUNC(SYSDATE) + TRUNC(DBMS_RANDOM.VALUE(30, 731)),
            -- Quantity received: 100-5000 units
            TRUNC(DBMS_RANDOM.VALUE(100, 5001)),
            -- Quantity remaining: 0-100% of received
            TRUNC(DBMS_RANDOM.VALUE(0, 
                CASE WHEN MOD(v_counter, 10) IN (0,1) THEN 500 ELSE 5001 END
            )),
            -- Unit price: $5-$200
            ROUND(DBMS_RANDOM.VALUE(5.00, 200.00), 2),
            -- Supplier name
            CASE MOD(v_counter, 6)
                WHEN 0 THEN 'Global Pharma'
                WHEN 1 THEN 'MediCorp'
                WHEN 2 THEN 'HealthCare Logistics'
                WHEN 3 THEN 'DrugWorld'
                WHEN 4 THEN 'QuickMed'
                WHEN 5 THEN 'BioSuppliers'
            END,
            -- Received date: between manufacture date and today
            TRUNC(SYSDATE) - TRUNC(DBMS_RANDOM.VALUE(1, 180)),
            -- Location
            'SHELF-' || CHR(65 + MOD(v_counter, 5)) || '-' || TRUNC(DBMS_RANDOM.VALUE(1, 51)),
            SYSDATE
        );
        
        v_counter := v_counter + 1;
        
        -- Show progress
        IF MOD(v_counter, 50) = 0 THEN
            DBMS_OUTPUT.PUT_LINE('  Inserted ' || v_counter || ' batches...');
        END IF;
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Successfully inserted 500 batches');
    
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate error at batch ' || v_counter || '! Rolling back...');
        ROLLBACK;
        RAISE;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error at batch ' || v_counter || ': ' || SQLERRM);
        ROLLBACK;
        RAISE;
END;
/

-- Step 5: Re-enable constraints
BEGIN
    -- Enable batches foreign key
    BEGIN
        EXECUTE IMMEDIATE 'ALTER TABLE batches ENABLE CONSTRAINT fk_batch_medicine';
        DBMS_OUTPUT.PUT_LINE('Enabled batches foreign key constraint');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Could not enable batches constraint: ' || SQLERRM);
    END;
    
    -- Enable alerts foreign key
    BEGIN
        EXECUTE IMMEDIATE 'ALTER TABLE alerts ENABLE CONSTRAINT fk_alert_batch';
        DBMS_OUTPUT.PUT_LINE('Enabled alerts foreign key constraint');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Could not enable alerts constraint: ' || SQLERRM);
    END;
END;
/

select COUNT(*) from batches;