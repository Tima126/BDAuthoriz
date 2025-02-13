-- Создание логинов на уровне сервера
CREATE LOGIN AdminLogin WITH PASSWORD = 'Admin@123';
CREATE LOGIN MedStaffLogin WITH PASSWORD = 'MedStaff@123';
CREATE LOGIN RegistrarLogin WITH PASSWORD = 'Registrar@123';
CREATE LOGIN DoctorLogin WITH PASSWORD = 'Doctor@123';
CREATE LOGIN PatientLogin WITH PASSWORD = 'Patient@123';


--- пользователи для БД
CREATE USER AdminUser FOR LOGIN AdminLogin;
CREATE USER MedStaffUser FOR LOGIN MedStaffLogin;
CREATE USER RegistrarUser FOR LOGIN RegistrarLogin;
CREATE USER DoctorUser FOR LOGIN DoctorLogin;
CREATE USER PatientUser FOR LOGIN PatientLogin;

--- роли 
CREATE ROLE AdminRole;
CREATE ROLE MedStaffRole;
CREATE ROLE RegistrarRole;
CREATE ROLE DoctorRole;
CREATE ROLE PatientRole;

-- Назначение пользователей ролям
ALTER ROLE AdminRole ADD MEMBER AdminUser;
ALTER ROLE MedStaffRole ADD MEMBER MedStaffUser;
ALTER ROLE RegistrarRole ADD MEMBER RegistrarUser;
ALTER ROLE DoctorRole ADD MEMBER DoctorUser;
ALTER ROLE PatientRole ADD MEMBER PatientUser;

-- Предоставление прав ролям

-- Права для роли Администратор (полный доступ ко всем таблицам)
GRANT CONTROL ON DATABASE::больница TO AdminRole;

-- Права для роли Медицинский персонал (чтение, вставка, обновление данных)
GRANT SELECT, INSERT, UPDATE ON SCHEMA::dbo TO MedStaffRole;

-- Права для роли Регистратор (добавление и просмотр записей)
GRANT SELECT, INSERT ON OBJECT::dbo.Записи TO RegistrarRole;

-- Права для роли Врач (доступ к данным своих пациентов)
GRANT SELECT, UPDATE ON OBJECT::dbo.Пациенты TO DoctorRole;
GRANT SELECT, UPDATE ON OBJECT::dbo.Записи TO DoctorRole;

-- Права для роли Пациент (ограниченный доступ к своим данным)
GRANT SELECT ON OBJECT::dbo.Пациенты TO PatientRole WHERE PatientID = USER_ID();
GRANT SELECT ON OBJECT::dbo.Записи TO PatientRole WHERE PatientID = USER_ID();



-- Запрет на удаление данных для Медицинского персонала
DENY DELETE ON SCHEMA::dbo TO MedStaffRole;

-- Запрет на изменение и удаление для Регистратора
DENY UPDATE, DELETE ON OBJECT::dbo.Записи TO RegistrarRole;

-- Запрет на доступ к другим таблицам для Пациента
DENY SELECT ON OBJECT::dbo.Врачи TO PatientRole;
DENY SELECT ON OBJECT::dbo.МедКарты TO PatientRole;

-- смена пароля для пользователя
ALTER LOGIN AdminLogin WITH PASSWORD = 'NewAdmin@123';

-- отключения пользователя
ALTER LOGIN MedStaffLogin DISABLE;

--  удаления пользователя из базы данных
DROP USER RegistrarUser;

-- удаления логина с сервера
DROP LOGIN RegistrarLogin;