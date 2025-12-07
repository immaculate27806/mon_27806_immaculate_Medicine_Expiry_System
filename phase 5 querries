-- 1. MANUFACTURERS TABLE
CREATE TABLE manufacturers (
    manufacturer_id NUMBER(10) PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    country VARCHAR2(50),
    contact_email VARCHAR2(100),
    phone VARCHAR2(20),
    is_active CHAR(1) DEFAULT 'Y' CHECK (is_active IN ('Y','N')),
    created_date DATE DEFAULT SYSDATE,
    CONSTRAINT uk_manufacturer_name UNIQUE (name)
) TABLESPACE MEDICINE_EXPIRY_DATA;



-- 1. MANUFACTURERS TABLE
CREATE TABLE manufacturers (
    manufacturer_id NUMBER(10) PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    country VARCHAR2(50),
    contact_email VARCHAR2(100),
    phone VARCHAR2(20),
    is_active CHAR(1) DEFAULT 'Y' CHECK (is_active IN ('Y','N')),
    created_date DATE DEFAULT SYSDATE,
    CONSTRAINT uk_manufacturer_name UNIQUE (name)
) TABLESPACE MEDICINE_EXPIRY_DATA;

-- 2. MEDICINES TABLE
CREATE TABLE medicines (
    medicine_id NUMBER(10) PRIMARY KEY,
    brand_name VARCHAR2(100) NOT NULL,
    generic_name VARCHAR2(100),
    form VARCHAR2(30) CHECK (form IN ('TABLET','SYRUP','INJECTION','CAPSULE','CREAM','OINTMENT','DROPS')),
    strength VARCHAR2(50),
    manufacturer_id NUMBER(10) NOT NULL,
    requires_prescription CHAR(1) DEFAULT 'Y' CHECK (requires_prescription IN ('Y','N')),
    therapeutic_category VARCHAR2(100),
    storage_conditions VARCHAR2(200),
    created_date DATE DEFAULT SYSDATE,
    CONSTRAINT fk_med_manufacturer FOREIGN KEY (manufacturer_id) 
        REFERENCES manufacturers(manufacturer_id),
    CONSTRAINT uk_medicine_brand UNIQUE (brand_name, manufacturer_id)
) TABLESPACE MEDICINE_EXPIRY_DATA;



-- 3. BATCHES TABLE (CORE TABLE - Will have triggers)
CREATE TABLE batches (
    batch_id NUMBER(10) PRIMARY KEY,
    medicine_id NUMBER(10) NOT NULL,
    batch_number VARCHAR2(50) NOT NULL,
    manufacture_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    quantity_received NUMBER(10) NOT NULL CHECK (quantity_received > 0),
    quantity_remaining NUMBER(10) NOT NULL CHECK (quantity_remaining >= 0),
    unit_price NUMBER(10,2) CHECK (unit_price >= 0),
    supplier_name VARCHAR2(100),
    received_date DATE DEFAULT SYSDATE,
    location VARCHAR2(50),
    last_updated DATE DEFAULT SYSDATE,
    CONSTRAINT fk_batch_medicine FOREIGN KEY (medicine_id) 
        REFERENCES medicines(medicine_id),
    CONSTRAINT uk_batch_number UNIQUE (batch_number),
    CONSTRAINT chk_expiry_date CHECK (expiry_date > manufacture_date),
    CONSTRAINT chk_quantity CHECK (quantity_remaining <= quantity_received)
) TABLESPACE MEDICINE_EXPIRY_DATA;



-- 4. RECALLS TABLE
CREATE TABLE recalls (
    recall_id NUMBER(10) PRIMARY KEY,
    manufacturer_id NUMBER(10) NOT NULL,
    batch_numbers VARCHAR2(500),
    reason VARCHAR2(500) NOT NULL,
    recall_date DATE NOT NULL,
    severity VARCHAR2(20) CHECK (severity IN ('HIGH','MEDIUM','LOW')),
    affected_countries VARCHAR2(200),
    announcement_date DATE DEFAULT SYSDATE,
    CONSTRAINT fk_recall_manufacturer FOREIGN KEY (manufacturer_id) 
        REFERENCES manufacturers(manufacturer_id)
) TABLESPACE MEDICINE_EXPIRY_DATA;



-- 5. USERS TABLE (For Phase VII business rule)
CREATE TABLE users (
    user_id NUMBER(10) PRIMARY KEY,
    username VARCHAR2(50) NOT NULL UNIQUE,
    password_hash VARCHAR2(100) NOT NULL,
    full_name VARCHAR2(100) NOT NULL,
    role VARCHAR2(30) NOT NULL CHECK (role IN ('PHARMACIST','MANAGER','ADMIN','EMPLOYEE_S')),
    department VARCHAR2(50),
    email VARCHAR2(100),
    phone VARCHAR2(20),
    is_active CHAR(1) DEFAULT 'Y' CHECK (is_active IN ('Y','N')),
    created_date DATE DEFAULT SYSDATE,
    last_login DATE
) TABLESPACE MEDICINE_EXPIRY_DATA;



-- 6. ALERTS TABLE
CREATE TABLE alerts (
    alert_id NUMBER(10) PRIMARY KEY,
    batch_id NUMBER(10) NOT NULL,
    alert_type VARCHAR2(30) NOT NULL CHECK (alert_type IN ('EXPIRY_WARNING','EXPIRED','RECALL')),
    alert_date DATE DEFAULT SYSDATE,
    status VARCHAR2(20) DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE','RESOLVED','ACKNOWLEDGED')),
    priority VARCHAR2(10) CHECK (priority IN ('HIGH','MEDIUM','LOW')),
    message VARCHAR2(500),
    days_remaining NUMBER(5),
    resolved_by NUMBER(10),
    resolved_date DATE,
    CONSTRAINT fk_alert_batch FOREIGN KEY (batch_id) 
        REFERENCES batches(batch_id),
    CONSTRAINT fk_alert_resolved_by FOREIGN KEY (resolved_by) 
        REFERENCES users(user_id)
) TABLESPACE MEDICINE_EXPIRY_DATA;


-- 7. AUDIT_LOGS TABLE (For Phase VII auditing)
CREATE TABLE audit_logs (
    log_id NUMBER(10) PRIMARY KEY,
    user_id NUMBER(10),
    action_type VARCHAR2(50) NOT NULL,
    table_name VARCHAR2(50) NOT NULL,
    record_id VARCHAR2(100),
    old_values CLOB,
    new_values CLOB,
    log_timestamp TIMESTAMP DEFAULT SYSTIMESTAMP,
    ip_address VARCHAR2(45),
    CONSTRAINT fk_audit_user FOREIGN KEY (user_id) 
        REFERENCES users(user_id)
) TABLESPACE MEDICINE_EXPIRY_DATA;



-- 8. HOLIDAYS TABLE (For Phase VII restriction)
CREATE TABLE holidays (
    holiday_id NUMBER(10) PRIMARY KEY,
    holiday_date DATE NOT NULL UNIQUE,
    holiday_name VARCHAR2(100) NOT NULL,
    country VARCHAR2(50) DEFAULT 'RWANDA',
    is_recurring CHAR(1) DEFAULT 'N' CHECK (is_recurring IN ('Y','N')),
    created_date DATE DEFAULT SYSDATE
) TABLESPACE MEDICINE_EXPIRY_DATA;



-- Indexes on BATCHES (most queried table)
CREATE INDEX idx_batches_medicine ON batches(medicine_id) 
    TABLESPACE MEDICINE_EXPIRY_INDEX;
    
CREATE INDEX idx_batches_expiry ON batches(expiry_date) 
    TABLESPACE MEDICINE_EXPIRY_INDEX;
    
CREATE INDEX idx_batches_batch_num ON batches(batch_number) 
    TABLESPACE MEDICINE_EXPIRY_INDEX;

-- Indexes on ALERTS
CREATE INDEX idx_alerts_batch ON alerts(batch_id) 
    TABLESPACE MEDICINE_EXPIRY_INDEX;
    
CREATE INDEX idx_alerts_status ON alerts(status, alert_date) 
    TABLESPACE MEDICINE_EXPIRY_INDEX;
    
CREATE INDEX idx_alerts_type ON alerts(alert_type) 
    TABLESPACE MEDICINE_EXPIRY_INDEX;

-- Indexes on MEDICINES
CREATE INDEX idx_med_manufacturer ON medicines(manufacturer_id) 
    TABLESPACE MEDICINE_EXPIRY_INDEX;
    
CREATE INDEX idx_med_brand ON medicines(brand_name) 
    TABLESPACE MEDICINE_EXPIRY_INDEX;

-- Indexes on AUDIT_LOGS
CREATE INDEX idx_audit_timestamp ON audit_logs(log_timestamp) 
    TABLESPACE MEDICINE_EXPIRY_INDEX;
    
CREATE INDEX idx_audit_user ON audit_logs(user_id) 
    TABLESPACE MEDICINE_EXPIRY_INDEX;

-- Index on USERS for role-based queries
CREATE INDEX idx_users_role ON users(role, department) 
    TABLESPACE MEDICINE_EXPIRY_INDEX;

-- Composite index for holiday queries
CREATE INDEX idx_holidays_date ON holidays(holiday_date, country) 
    TABLESPACE MEDICINE_EXPIRY_INDEX;
