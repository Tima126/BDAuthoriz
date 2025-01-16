-- ������� ����� (������ � ����)
CREATE SERVER AUDIT Database_Audit
TO FILE 
(FILEPATH = 'C:\AuditLogs\',
 MAXSIZE = 10 MB,
 MAX_ROLLOVER_FILES = 5,
 RESERVE_DISK_SPACE = OFF);
GO

-- ������� ������������ ������ ���� ������
CREATE DATABASE AUDIT SPECIFICATION Database_Audit_Specification
FOR SERVER AUDIT Database_Audit  
    ADD (INSERT ON dbo.Products BY dbo),  
    ADD (UPDATE ON dbo.Products BY dbo), 
    ADD (DELETE ON dbo.Products BY dbo);
GO

-- �������� �����
ALTER SERVER AUDIT Database_Audit  
WITH (STATE = ON);  
GO

-- �������� ������������ ������
ALTER DATABASE AUDIT SPECIFICATION Database_Audit_Specification
WITH (STATE = ON);
GO

SELECT event_time, action_id, succeeded, object_name, statement
FROM sys.fn_get_audit_file('C:\AuditLogs\*.sqlaudit', DEFAULT, DEFAULT)
WHERE object_name = 'Products'; 

