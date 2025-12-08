-- COMPLETE RECALLS INSERTION SCRIPT (50 records)

BEGIN
    -- First, create sequence if it doesn't exist
    BEGIN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE seq_recalls START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE';
        DBMS_OUTPUT.PUT_LINE('Created sequence seq_recalls');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -955 THEN -- sequence already exists
                DBMS_OUTPUT.PUT_LINE('Sequence seq_recalls already exists');
            ELSE
                RAISE;
            END IF;
    END;

    -- Disable foreign key constraint temporarily
    BEGIN
        EXECUTE IMMEDIATE 'ALTER TABLE recalls DISABLE CONSTRAINT fk_recall_manufacturer';
        DBMS_OUTPUT.PUT_LINE('Disabled foreign key constraint temporarily');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Note: Could not disable constraint - ' || SQLERRM);
    END;

    -- Clear existing data (optional)
    BEGIN
        EXECUTE IMMEDIATE 'DELETE FROM recalls';
        DBMS_OUTPUT.PUT_LINE('Cleared existing recall data');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Note: Could not clear table - ' || SQLERRM);
    END;

    DBMS_OUTPUT.PUT_LINE('Inserting 50 recall records...');

    -- Insert 50 recall records
    DECLARE
        v_recall_id NUMBER;
        v_manufacturer_id NUMBER;
        v_batch_numbers VARCHAR2(500);
        v_reason VARCHAR2(500);
        v_recall_date DATE;
        v_severity VARCHAR2(20);
        v_affected_countries VARCHAR2(200);
        v_announcement_date DATE;
        v_counter NUMBER := 1;
    BEGIN
        WHILE v_counter <= 50 LOOP
            -- Get next sequence value
            SELECT seq_recalls.NEXTVAL INTO v_recall_id FROM DUAL;
            
            -- Random manufacturer_id between 1-100
            v_manufacturer_id := TRUNC(DBMS_RANDOM.VALUE(1, 101));
            
            -- Generate batch numbers (realistic batch numbers)
            v_batch_numbers := 
                CASE MOD(v_counter, 5)
                    WHEN 0 THEN 'BATCH-' || LPAD(TRUNC(DBMS_RANDOM.VALUE(1, 500)), 6, '0') || 
                               ',BATCH-' || LPAD(TRUNC(DBMS_RANDOM.VALUE(1, 500)), 6, '0')
                    WHEN 1 THEN 'BATCH-' || LPAD(TRUNC(DBMS_RANDOM.VALUE(1, 500)), 6, '0') || 
                               ',BATCH-' || LPAD(TRUNC(DBMS_RANDOM.VALUE(1, 500)), 6, '0') ||
                               ',BATCH-' || LPAD(TRUNC(DBMS_RANDOM.VALUE(1, 500)), 6, '0')
                    WHEN 2 THEN 'BATCH-' || LPAD(TRUNC(DBMS_RANDOM.VALUE(1, 500)), 6, '0')
                    WHEN 3 THEN 'LOT-' || LPAD(TRUNC(DBMS_RANDOM.VALUE(1000, 9999)), 4, '0') || 
                               ',LOT-' || LPAD(TRUNC(DBMS_RANDOM.VALUE(1000, 9999)), 4, '0')
                    WHEN 4 THEN 'EXP-' || TO_CHAR(SYSDATE-180, 'YYYYMM') || '-001' ||
                               ',EXP-' || TO_CHAR(SYSDATE-180, 'YYYYMM') || '-002'
                END;
            
            -- Generate recall reason
            v_reason := 
                CASE MOD(v_counter, 15)
                    WHEN 0 THEN 'Microbial contamination detected during routine testing'
                    WHEN 1 THEN 'Active pharmaceutical ingredient (API) out of specification'
                    WHEN 2 THEN 'Presence of foreign particles in vials'
                    WHEN 3 THEN 'Labeling error - incorrect dosage information'
                    WHEN 4 THEN 'Packaging defect affecting product sterility'
                    WHEN 5 THEN 'Dissolution test failure - tablets not dissolving properly'
                    WHEN 6 THEN 'Stability data indicates degradation beyond acceptable limits'
                    WHEN 7 THEN 'Discoloration observed in stored samples'
                    WHEN 8 THEN 'Manufacturing process deviation - temperature out of range'
                    WHEN 9 THEN 'Quality control test failure for impurity levels'
                    WHEN 10 THEN 'Incorrect batch documentation discovered'
                    WHEN 11 THEN 'Potential cross-contamination during manufacturing'
                    WHEN 12 THEN 'Product strength below specification'
                    WHEN 13 THEN 'Glass particles found in injection solution'
                    WHEN 14 THEN 'Tamper-evident seal compromised'
                END;
            
            -- Generate recall date (within last 2 years)
            v_recall_date := TRUNC(SYSDATE) - TRUNC(DBMS_RANDOM.VALUE(1, 730));
            
            -- Generate severity (20% HIGH, 30% MEDIUM, 50% LOW)
            CASE MOD(v_counter, 10)
                WHEN 0 THEN v_severity := 'HIGH';
                WHEN 1 THEN v_severity := 'HIGH';
                WHEN 2 THEN v_severity := 'MEDIUM';
                WHEN 3 THEN v_severity := 'MEDIUM';
                WHEN 4 THEN v_severity := 'MEDIUM';
                ELSE v_severity := 'LOW';
            END CASE;
            
            -- Generate affected countries
            v_affected_countries := 
                CASE MOD(v_counter, 8)
                    WHEN 0 THEN 'RWANDA,UGANDA,KENYA'
                    WHEN 1 THEN 'EAST AFRICA REGION'
                    WHEN 2 THEN 'GLOBAL'
                    WHEN 3 THEN 'UNITED STATES,CANADA'
                    WHEN 4 THEN 'EUROPEAN UNION COUNTRIES'
                    WHEN 5 THEN 'ASIA PACIFIC REGION'
                    WHEN 6 THEN 'MIDDLE EAST AND NORTH AFRICA'
                    WHEN 7 THEN 'LATIN AMERICA'
                END;
            
            -- Announcement date is 1-7 days before recall date
            v_announcement_date := v_recall_date - TRUNC(DBMS_RANDOM.VALUE(1, 8));
            
            -- Insert the recall record
            INSERT INTO recalls (
                recall_id, manufacturer_id, batch_numbers, reason, 
                recall_date, severity, affected_countries, announcement_date
            ) VALUES (
                v_recall_id,
                v_manufacturer_id,
                v_batch_numbers,
                v_reason,
                v_recall_date,
                v_severity,
                v_affected_countries,
                v_announcement_date
            );
            
            v_counter := v_counter + 1;
            
            -- Show progress every 10 records
            IF MOD(v_counter, 10) = 0 THEN
                DBMS_OUTPUT.PUT_LINE('  Processed ' || (v_counter-1) || ' recalls...');
            END IF;
        END LOOP;
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Successfully inserted 50 recalls');
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error at record ' || v_counter || ': ' || SQLERRM);
            ROLLBACK;
            RAISE;
    END;
    
    -- Re-enable foreign key constraint
    BEGIN
        EXECUTE IMMEDIATE 'ALTER TABLE recalls ENABLE CONSTRAINT fk_recall_manufacturer';
        DBMS_OUTPUT.PUT_LINE('Re-enabled foreign key constraint');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Warning: Could not re-enable constraint - ' || SQLERRM);
    END;
    
    DBMS_OUTPUT.PUT_LINE('Recalls table population completed successfully!');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Fatal error: ' || SQLERRM);
        ROLLBACK;
        RAISE;
END;
/

SELECT COUNT(*) FROM recalls;