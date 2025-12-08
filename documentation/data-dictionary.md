# **Data Dictionary: Medicine Expiry Management System**

## **Overview**
This data dictionary documents the database schema for a Medicine Expiry Management System. The system tracks medicine inventory, manages expiry dates, handles recalls, and generates alerts for timely action.

---

## **Table: MANUFACTURERS**
| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
| manufacturer_id | NUMBER(10) | NOT NULL | - | PRIMARY KEY | Unique identifier for medicine manufacturer |
| name | VARCHAR2(100) | NOT NULL | - | UNIQUE | Company name of the manufacturer |
| country | VARCHAR2(50) | NULL | - | - | Country where manufacturer is based |
| contact_email | VARCHAR2(100) | NULL | - | - | Contact email address for the manufacturer |
| phone | VARCHAR2(20) | NULL | - | - | Contact phone number for the manufacturer |
| is_active | CHAR(1) | NULL | 'Y' | CHECK (is_active IN ('Y','N')) | Indicates whether the manufacturer is still active |
| created_date | DATE | NULL | SYSDATE | - | Timestamp when the manufacturer record was created |

**Business Purpose:** Stores information about pharmaceutical manufacturers who produce the medicines.

---

## **Table: MEDICINES**
| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
| medicine_id | NUMBER(10) | NOT NULL | - | PRIMARY KEY | Unique identifier for each medicine |
| brand_name | VARCHAR2(100) | NOT NULL | - | - | Commercial/brand name of the medicine |
| generic_name | VARCHAR2(100) | NULL | - | - | Generic/scientific name of the medicine |
| form | VARCHAR2(30) | NULL | - | CHECK (form IN ('TABLET','SYRUP','INJECTION','CAPSULE','CREAM','OINTMENT','DROPS')) | Physical form of the medicine |
| strength | VARCHAR2(50) | NULL | - | - | Potency/dosage strength of the medicine |
| manufacturer_id | NUMBER(10) | NOT NULL | - | FOREIGN KEY (references MANUFACTURERS.manufacturer_id) | Reference to the manufacturer who produces this medicine |
| requires_prescription | CHAR(1) | NULL | 'Y' | CHECK (requires_prescription IN ('Y','N')) | Indicates if a prescription is required to dispense this medicine |
| therapeutic_category | VARCHAR2(100) | NULL | - | - | Medical/therapeutic category of the medicine |
| storage_conditions | VARCHAR2(200) | NULL | - | - | Special storage requirements for the medicine |
| created_date | DATE | NULL | SYSDATE | - | Timestamp when the medicine record was created |

**Business Purpose:** Catalog of all medicines available in the inventory with their specifications.

---

## **Table: BATCHES**
| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
| batch_id | NUMBER(10) | NOT NULL | - | PRIMARY KEY | Unique identifier for each batch/lot |
| medicine_id | NUMBER(10) | NOT NULL | - | FOREIGN KEY (references MEDICINES.medicine_id) | Reference to the specific medicine |
| batch_number | VARCHAR2(50) | NOT NULL | - | UNIQUE | Manufacturer's batch/lot identification number |
| manufacture_date | DATE | NOT NULL | - | - | Date when the batch was manufactured |
| expiry_date | DATE | NOT NULL | - | CHECK (expiry_date > manufacture_date) | Date when the batch expires |
| quantity_received | NUMBER(10) | NOT NULL | - | CHECK (quantity_received > 0) | Total quantity received for this batch |
| quantity_remaining | NUMBER(10) | NOT NULL | - | CHECK (quantity_remaining >= 0) | Current stock quantity remaining |
| unit_price | NUMBER(10,2) | NULL | - | CHECK (unit_price >= 0) | Price per unit of the medicine |
| supplier_name | VARCHAR2(100) | NULL | - | - | Name of the supplier/vendor who provided the batch |
| received_date | DATE | NULL | SYSDATE | - | Date when the batch was received in inventory |
| location | VARCHAR2(50) | NULL | - | - | Storage location within the warehouse/facility |
| last_updated | DATE | NULL | SYSDATE | - | Timestamp of the last update to this batch record |

**Business Purpose:** Tracks individual batches/lots of medicines with their specific manufacturing and expiry details.

---

## **Table: RECALLS**
| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
| recall_id | NUMBER(10) | NOT NULL | - | PRIMARY KEY | Unique identifier for each recall |
| manufacturer_id | NUMBER(10) | NOT NULL | - | FOREIGN KEY (references MANUFACTURERS.manufacturer_id) | Manufacturer issuing the recall |
| batch_numbers | VARCHAR2(500) | NULL | - | - | List of affected batch numbers |
| reason | VARCHAR2(500) | NOT NULL | - | - | Reason for the recall |
| recall_date | DATE | NOT NULL | - | - | Date when the recall was issued |
| severity | VARCHAR2(20) | NULL | - | CHECK (severity IN ('HIGH','MEDIUM','LOW')) | Severity level of the recall |
| affected_countries | VARCHAR2(200) | NULL | - | - | Countries affected by the recall |
| announcement_date | DATE | NULL | SYSDATE | - | Date when the recall was announced to the system |

**Business Purpose:** Records product recalls issued by manufacturers for safety or quality issues.

---

## **Table: USERS**
| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
| user_id | NUMBER(10) | NOT NULL | - | PRIMARY KEY | Unique identifier for system user |
| username | VARCHAR2(50) | NOT NULL | - | UNIQUE | Login username for the system |
| password_hash | VARCHAR2(100) | NOT NULL | - | - | Hashed password for authentication |
| full_name | VARCHAR2(100) | NOT NULL | - | - | Full name of the user |
| role | VARCHAR2(30) | NOT NULL | - | CHECK (role IN ('PHARMACIST','MANAGER','ADMIN','EMPLOYEE_S')) | User role/permission level |
| department | VARCHAR2(50) | NULL | - | - | Department where the user works |
| email | VARCHAR2(100) | NULL | - | - | Contact email address |
| phone | VARCHAR2(20) | NULL | - | - | Contact phone number |
| is_active | CHAR(1) | NULL | 'Y' | CHECK (is_active IN ('Y','N')) | Indicates if the user account is active |
| created_date | DATE | NULL | SYSDATE | - | Date when the user account was created |
| last_login | DATE | NULL | - | - | Timestamp of the user's last login |

**Business Purpose:** Manages system users with different roles and permissions for accessing the system.

---

## **Table: ALERTS**
| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
| alert_id | NUMBER(10) | NOT NULL | - | PRIMARY KEY | Unique identifier for each alert |
| batch_id | NUMBER(10) | NOT NULL | - | FOREIGN KEY (references BATCHES.batch_id) | Reference to the batch triggering the alert |
| alert_type | VARCHAR2(30) | NOT NULL | - | CHECK (alert_type IN ('EXPIRY_WARNING','EXPIRED','RECALL')) | Type of alert generated |
| alert_date | DATE | NULL | SYSDATE | - | Date when the alert was generated |
| status | VARCHAR2(20) | NULL | 'ACTIVE' | CHECK (status IN ('ACTIVE','RESOLVED','ACKNOWLEDGED')) | Current status of the alert |
| priority | VARCHAR2(10) | NULL | - | CHECK (priority IN ('HIGH','MEDIUM','LOW')) | Priority level of the alert |
| message | VARCHAR2(500) | NULL | - | - | Detailed message explaining the alert |
| days_remaining | NUMBER(5) | NULL | - | - | Number of days remaining until expiry (for expiry warnings) |
| resolved_by | NUMBER(10) | NULL | - | FOREIGN KEY (references USERS.user_id) | User who resolved the alert |
| resolved_date | DATE | NULL | - | - | Date when the alert was resolved |

**Business Purpose:** Generates and tracks alerts for expiring medicines, expired batches, and recalls.

---

## **Foreign Key Relationships**

| Relationship | Parent Table | Parent Column | Child Table | Child Column | Description |
|--------------|--------------|---------------|-------------|--------------|-------------|
| FK_MED_MANUFACTURER | MANUFACTURERS | manufacturer_id | MEDICINES | manufacturer_id | Links medicines to their manufacturers |
| FK_BATCH_MEDICINE | MEDICINES | medicine_id | BATCHES | medicine_id | Links batches to specific medicines |
| FK_RECALL_MANUFACTURER | MANUFACTURERS | manufacturer_id | RECALLS | manufacturer_id | Links recalls to manufacturers |
| FK_ALERT_BATCH | BATCHES | batch_id | ALERTS | batch_id | Links alerts to specific batches |
| FK_ALERT_RESOLVED_BY | USERS | user_id | ALERTS | resolved_by | Links resolved alerts to users |

---

## **Business Rules Summary**

1. **Inventory Management**: Each batch must have a unique batch number and track quantity separately from received vs. remaining.
2. **Expiry Control**: Batch expiry dates must be after manufacture dates, triggering alerts when approaching expiry.
3. **Recall Tracking**: Manufacturers can issue recalls affecting specific batch numbers with severity levels.
4. **User Access Control**: Different user roles (Pharmacist, Manager, Admin) have varying system permissions.
5. **Alert System**: Automated alerts for expiring medicines, expired batches, and active recalls.
6. **Prescription Control**: Medicines are classified as requiring or not requiring prescriptions.

---

## **Data Integrity Constraints**

1. **Primary Keys**: All tables have primary keys ensuring unique identification of records.
2. **Foreign Keys**: Referential integrity maintained through foreign key constraints.
3. **Check Constraints**: Enforce business rules (e.g., expiry date > manufacture date).
4. **Unique Constraints**: Prevent duplicate manufacturer names, batch numbers, and usernames.
5. **Default Values**: Automatic timestamps for creation dates and default status values.

---

## **Index Summary**

| Table | Index Name | Columns Indexed | Purpose |
|-------|------------|-----------------|---------|
| BATCHES | IDX_BATCHES_MEDICINE | medicine_id | Speed up queries filtering by medicine |
| BATCHES | IDX_BATCHES_EXPIRY | expiry_date | Optimize expiry date range queries |
| BATCHES | IDX_BATCHES_BATCH_NUM | batch_number | Fast lookup by batch number |
| ALERTS | IDX_ALERTS_BATCH | batch_id | Efficient join with batches table |
| ALERTS | IDX_ALERTS_STATUS | status, alert_date | Quick filtering by status and date |
| ALERTS | IDX_ALERTS_TYPE | alert_type | Fast filtering by alert type |
| MEDICINES | IDX_MED_MANUFACTURER | manufacturer_id | Optimize manufacturer-based queries |
| MEDICINES | IDX_MED_BRAND | brand_name | Quick search by medicine brand name |
| USERS | IDX_USERS_ROLE | role, department | Efficient role-based access queries |

This data dictionary provides comprehensive documentation of the database schema, supporting system maintenance, development, and compliance requirements.