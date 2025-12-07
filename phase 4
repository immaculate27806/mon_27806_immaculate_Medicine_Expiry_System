# Smart Medicine Expiry and Recall Alert System
## Database Implementation - Phase IV

**Student:** MUTARUTWA Immaculate  
**ID:** 27806  
**Course:** Database Development with PL/SQL (INSY 8311)  
**Institution:** Adventist University of Central Africa (AUCA)  
**Date:** December 6, 2025  

### Database Configuration
- **PDB Name:** mon_27806_immaculate_Medicine_Expiry_Alert_System_db
- **Admin User:** immaculate_admin
- **Application User:** MEDICINE_EXPIRY_USER
- **Tablespaces:** 
  - MEDICINE_EXPIRY_DATA (100MB, autoextend to 1GB)
"C:\Users\my account\OneDrive\Desktop\scrnsh pl\data tablespace creation.png"
  - MEDICINE_EXPIRY_INDEX (50MB, autoextend to 500MB)
"C:\Users\my account\OneDrive\Desktop\scrnsh pl\index tablespace creation.png"
  - MEDICINE_EXPIRY_TEMP (50MB temp tablespace)
"C:\Users\my account\OneDrive\Desktop\scrnsh pl\temporary tablespace creation.png"

### Connection Details
- **Host:** localhost
- **Port:** 1521
- **Service Name:** mon_27806_immaculate_Medicine_Expiry_Alert_System_db
- **Admin:** immaculate_admin/admin
- **App User:** MEDICINE_EXPIRY_USER/immaculate

### Setup Verification Queries
```sql
-- Verify PDB status
SELECT name, open_mode FROM v$pdbs WHERE name = 'MON_27806_IMMACULATE_MEDICINE_EXPIRY_ALERT_SYSTEM_DB';

-- Verify tablespaces
SELECT tablespace_name, status, contents FROM user_tablespaces 
WHERE tablespace_name LIKE 'MEDICINE_EXPIRY%';

-- Verify user privileges
SELECT privilege FROM dba_sys_privs WHERE grantee = 'MEDICINE_EXPIRY_USER'
UNION
SELECT privilege FROM dba_sys_privs WHERE grantee IN (
SELECT granted_role FROM dba_role_privs WHERE grantee = 'MEDICINE_EXPIRY_USER'
);
