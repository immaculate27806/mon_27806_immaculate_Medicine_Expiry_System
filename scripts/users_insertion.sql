---- 1. Clean up
--DELETE FROM users;
--COMMIT;

-- 2. Reset sequence
DROP SEQUENCE seq_users;
CREATE SEQUENCE seq_users START WITH 1 INCREMENT BY 1;

-- 3. Insert first 20 users with INSERT ALL
INSERT ALL
    INTO users VALUES (seq_users.NEXTVAL, 'admin1', 'hash1', 'Admin One', 'ADMIN', 'IT', 'admin1@med.rw', '+250-788-100001', 'Y', SYSDATE-365, SYSDATE)
    INTO users VALUES (seq_users.NEXTVAL, 'manager1', 'hash2', 'Manager One', 'MANAGER', 'Pharmacy', 'manager1@med.rw', '+250-788-100002', 'Y', SYSDATE-300, SYSDATE-5)
    INTO users VALUES (seq_users.NEXTVAL, 'pharm1', 'hash3', 'Pharmacist One', 'PHARMACIST', 'Pharmacy', 'pharm1@med.rw', '+250-788-100003', 'Y', SYSDATE-250, SYSDATE-3)
    INTO users VALUES (seq_users.NEXTVAL, 'emp1', 'hash4', 'Employee One', 'EMPLOYEE_S', 'Sales', 'emp1@med.rw', '+250-788-100004', 'Y', SYSDATE-200, SYSDATE-7)
    INTO users VALUES (seq_users.NEXTVAL, 'admin2', 'hash5', 'Admin Two', 'ADMIN', 'Admin', 'admin2@med.rw', '+250-788-100005', 'Y', SYSDATE-150, SYSDATE-2)
    INTO users VALUES (seq_users.NEXTVAL, 'manager2', 'hash6', 'Manager Two', 'MANAGER', 'Inventory', 'manager2@med.rw', '+250-788-100006', 'Y', SYSDATE-120, SYSDATE-4)
    INTO users VALUES (seq_users.NEXTVAL, 'pharm2', 'hash7', 'Pharmacist Two', 'PHARMACIST', 'Pharmacy', 'pharm2@med.rw', '+250-788-100007', 'Y', SYSDATE-100, SYSDATE-1)
    INTO users VALUES (seq_users.NEXTVAL, 'emp2', 'hash8', 'Employee Two', 'EMPLOYEE_S', 'Support', 'emp2@med.rw', '+250-788-100008', 'Y', SYSDATE-80, SYSDATE-8)
    INTO users VALUES (seq_users.NEXTVAL, 'pharm3', 'hash9', 'Pharmacist Three', 'PHARMACIST', 'Pharmacy', 'pharm3@med.rw', '+250-788-100009', 'Y', SYSDATE-60, SYSDATE-6)
    INTO users VALUES (seq_users.NEXTVAL, 'emp3', 'hash10', 'Employee Three', 'EMPLOYEE_S', 'Sales', 'emp3@med.rw', '+250-788-100010', 'Y', SYSDATE-40, SYSDATE-9)
    INTO users VALUES (seq_users.NEXTVAL, 'pharm4', 'hash11', 'Pharmacist Four', 'PHARMACIST', 'Pharmacy', 'pharm4@med.rw', '+250-788-100011', 'N', SYSDATE-180, SYSDATE-100)
    INTO users VALUES (seq_users.NEXTVAL, 'manager3', 'hash12', 'Manager Three', 'MANAGER', 'Management', 'manager3@med.rw', '+250-788-100012', 'Y', SYSDATE-90, SYSDATE-3)
    INTO users VALUES (seq_users.NEXTVAL, 'admin3', 'hash13', 'Admin Three', 'ADMIN', 'IT', 'admin3@med.rw', '+250-788-100013', 'Y', SYSDATE-70, SYSDATE-2)
    INTO users VALUES (seq_users.NEXTVAL, 'pharm5', 'hash14', 'Pharmacist Five', 'PHARMACIST', 'Pharmacy', 'pharm5@med.rw', '+250-788-100014', 'Y', SYSDATE-50, SYSDATE-5)
    INTO users VALUES (seq_users.NEXTVAL, 'emp4', 'hash15', 'Employee Four', 'EMPLOYEE_S', 'Support', 'emp4@med.rw', '+250-788-100015', 'Y', SYSDATE-30, SYSDATE-7)
    INTO users VALUES (seq_users.NEXTVAL, 'pharm6', 'hash16', 'Pharmacist Six', 'PHARMACIST', 'Pharmacy', 'pharm6@med.rw', '+250-788-100016', 'Y', SYSDATE-25, SYSDATE-4)
    INTO users VALUES (seq_users.NEXTVAL, 'manager4', 'hash17', 'Manager Four', 'MANAGER', 'Operations', 'manager4@med.rw', '+250-788-100017', 'Y', SYSDATE-20, SYSDATE-6)
    INTO users VALUES (seq_users.NEXTVAL, 'admin4', 'hash18', 'Admin Four', 'ADMIN', 'Admin', 'admin4@med.rw', '+250-788-100018', 'Y', SYSDATE-15, SYSDATE-8)
    INTO users VALUES (seq_users.NEXTVAL, 'emp5', 'hash19', 'Employee Five', 'EMPLOYEE_S', 'Sales', 'emp5@med.rw', '+250-788-100019', 'Y', SYSDATE-10, SYSDATE-10)
    INTO users VALUES (seq_users.NEXTVAL, 'pharm7', 'hash20', 'Pharmacist Seven', 'PHARMACIST', 'Pharmacy', 'pharm7@med.rw', '+250-788-100020', 'Y', SYSDATE-5, SYSDATE-1)
SELECT 1 FROM DUAL;

COMMIT;

-- 4. Insert remaining 80 users with INSERT SELECT
INSERT INTO users (user_id, username, password_hash, full_name, role, department, email, phone, is_active, created_date, last_login)
SELECT 
    seq_users.NEXTVAL,
    'med_user_' || LEVEL,
    'pwd_' || DBMS_RANDOM.STRING('A', 10),
    'Staff Member ' || LEVEL,
    CASE 
        WHEN MOD(LEVEL, 4) = 0 THEN 'ADMIN'
        WHEN MOD(LEVEL, 4) = 1 THEN 'MANAGER'
        WHEN MOD(LEVEL, 4) = 2 THEN 'PHARMACIST'
        ELSE 'EMPLOYEE_S'
    END,
    CASE MOD(LEVEL, 6)
        WHEN 0 THEN 'Pharmacy'
        WHEN 1 THEN 'Inventory'
        WHEN 2 THEN 'Management'
        WHEN 3 THEN 'Sales'
        WHEN 4 THEN 'Support'
        WHEN 5 THEN 'Administration'
    END,
    'staff' || LEVEL || '@medsystem.rw',
    '+250-78' || LPAD(200000 + LEVEL, 6, '0'),
    CASE WHEN MOD(LEVEL, 8) = 0 THEN 'N' ELSE 'Y' END,
    SYSDATE - TRUNC(DBMS_RANDOM.VALUE(0, 365)),
    CASE 
        WHEN MOD(LEVEL, 5) = 0 THEN NULL
        ELSE SYSDATE - TRUNC(DBMS_RANDOM.VALUE(0, 90))
    END
FROM DUAL
CONNECT BY LEVEL <= 80;

COMMIT;

-- ADD 20 NEW USERS (Beyond the existing 100)
-- This script adds 20 additional users with unique usernames

BEGIN
    DBMS_OUTPUT.PUT_LINE('Adding 20 new users...');
    
    -- Insert 20 additional users
    INSERT INTO users (user_id, username, password_hash, full_name, role, department, email, phone, is_active, created_date, last_login)
    SELECT 
        seq_users.NEXTVAL,
        'new_user_' || TO_CHAR(SYSDATE, 'YYYYMMDD') || '_' || LPAD(LEVEL, 3, '0'),
        'secure_hash_' || DBMS_RANDOM.STRING('X', 16),
        CASE MOD(LEVEL, 10)
            WHEN 0 THEN 'Dr. Patrick Nizeyimana'
            WHEN 1 THEN 'Dr. Alice Uwase'
            WHEN 2 THEN 'Prof. Jean Claude'
            WHEN 3 THEN 'Ms. Grace Ingabire'
            WHEN 4 THEN 'Mr. Samuel Mugisha'
            WHEN 5 THEN 'Dr. Rose Mutoni'
            WHEN 6 THEN 'Mr. David Habimana'
            WHEN 7 THEN 'Mrs. Chantal Iradukunda'
            WHEN 8 THEN 'Dr. Eric Kayonga'
            WHEN 9 THEN 'Ms. Linda Mutesi'
        END,
        CASE 
            WHEN LEVEL <= 2 THEN 'ADMIN'
            WHEN LEVEL <= 5 THEN 'MANAGER'
            WHEN LEVEL <= 15 THEN 'PHARMACIST'
            ELSE 'EMPLOYEE_S'
        END,
        CASE 
            WHEN LEVEL <= 2 THEN 'Executive Management'
            WHEN LEVEL <= 5 THEN 'Regional Operations'
            WHEN LEVEL <= 8 THEN 'Clinical Pharmacy'
            WHEN LEVEL <= 11 THEN 'Pharmaceutical Services'
            WHEN LEVEL <= 14 THEN 'Quality Assurance'
            WHEN LEVEL <= 17 THEN 'Regulatory Affairs'
            ELSE 'Customer Relations'
        END,
        'user.new' || (100 + LEVEL) || '@medsystem.rw',
        '+250-78' || LPAD(900000 + LEVEL, 6, '0'),
        'Y',  -- All new users are active
        SYSDATE - TRUNC(DBMS_RANDOM.VALUE(1, 60)),  -- Created 1-60 days ago
        SYSDATE - TRUNC(DBMS_RANDOM.VALUE(0, 30))   -- Last login 0-30 days ago
    FROM DUAL
    CONNECT BY LEVEL <= 20;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Successfully added 20 new users');
    
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate username error! Some users already exist.');
        ROLLBACK;
        RAISE;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
        RAISE;
END;
/
-- 5. Verify
SELECT COUNT(*) FROM users;