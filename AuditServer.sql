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
