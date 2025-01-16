-- Создание 
CREATE SERVER AUDIT HIPAA_Audit
TO FILE 
(FILEPATH = 'C:\AuditLogs\',
 MAXSIZE = 10 MB,
 MAX_ROLLOVER_FILES = 5,
 RESERVE_DISK_SPACE = OFF);
GO

-- Создание спецификации сервера для аудита
CREATE SERVER AUDIT SPECIFICATION HIPAA_Audit_Specificatio
FOR SERVER AUDIT HIPAA_Audit  
    ADD (FAILED_LOGIN_GROUP),          -- Неудачные попытки авторизации
    ADD (BACKUP_RESTORE_GROUP),        -- Создание резервной копии
    ADD (SERVER_OBJECT_CHANGE_GROUP);  -- Изменения объектов на уровне сервера
GO
 

-- Включение
ALTER SERVER AUDIT HIPAA_Audit  
WITH (STATE = on);  
GO



SELECT 
    event_time,         
    action_id,          
    succeeded,          
    session_server_principal_name, 
    database_name,      
    object_name,        
    statement           
FROM sys.fn_get_audit_file('C:\AuditLogs\*.sqlaudit', DEFAULT, DEFAULT);



BACKUP DATABASE Supermarket
TO DISK = 'C:\Backup\Supermarket.bak'
WITH FORMAT, 
     INIT,   
     NAME = 'Полный Бэкап Supermarket',
     STATS = 10; 

DROP LOGIN User2;

SELECT *
FROM sys.fn_get_audit_file('C:\AuditLogs\*.sqlaudit', DEFAULT, DEFAULT);




CREATE LOGIN User2 WITH PASSWORD = '12345';



SELECT name, is_disabled 
FROM sys.sql_logins
WHERE name = 'User2';

CREATE LOGIN User22 WITH PASSWORD = '0000';
ALTER SERVER ROLE sysadmin ADD MEMBER User22;

ALTER SERVER ROLE public ADD MEMBER User22;



ALTER LOGIN Tim WITH NAME = Tm;
