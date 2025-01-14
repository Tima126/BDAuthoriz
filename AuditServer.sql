-- �������� 
CREATE SERVER AUDIT HIPAA_Audit
TO FILE 
(FILEPATH = 'C:\AuditLogs\',
 MAXSIZE = 10 MB,
 MAX_ROLLOVER_FILES = 5,
 RESERVE_DISK_SPACE = OFF);
GO

-- �������� ������������ ������� ��� ������
CREATE SERVER AUDIT SPECIFICATION HIPAA_Audit_Specificatio
FOR SERVER AUDIT HIPAA_Audit  
    ADD (FAILED_LOGIN_GROUP),          -- ��������� ������� �����������
    ADD (BACKUP_RESTORE_GROUP),        -- �������� ��������� �����
    ADD (SERVER_OBJECT_CHANGE_GROUP);  -- ��������� �������� �� ������ �������
GO
 

-- ���������
ALTER SERVER AUDIT HIPAA_Audit  
WITH (STATE = on);  
GO
