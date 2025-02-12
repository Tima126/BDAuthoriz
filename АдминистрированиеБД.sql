-- �������� ������� �� ������ �������
CREATE LOGIN AdminLogin WITH PASSWORD = 'Admin@123';
CREATE LOGIN MedStaffLogin WITH PASSWORD = 'MedStaff@123';
CREATE LOGIN RegistrarLogin WITH PASSWORD = 'Registrar@123';
CREATE LOGIN DoctorLogin WITH PASSWORD = 'Doctor@123';
CREATE LOGIN PatientLogin WITH PASSWORD = 'Patient@123';


--- ������������ ��� ��
CREATE USER AdminUser FOR LOGIN AdminLogin;
CREATE USER MedStaffUser FOR LOGIN MedStaffLogin;
CREATE USER RegistrarUser FOR LOGIN RegistrarLogin;
CREATE USER DoctorUser FOR LOGIN DoctorLogin;
CREATE USER PatientUser FOR LOGIN PatientLogin;

--- ���� 
CREATE ROLE AdminRole;
CREATE ROLE MedStaffRole;
CREATE ROLE RegistrarRole;
CREATE ROLE DoctorRole;
CREATE ROLE PatientRole;

-- ���������� ������������� �����
ALTER ROLE AdminRole ADD MEMBER AdminUser;
ALTER ROLE MedStaffRole ADD MEMBER MedStaffUser;
ALTER ROLE RegistrarRole ADD MEMBER RegistrarUser;
ALTER ROLE DoctorRole ADD MEMBER DoctorUser;
ALTER ROLE PatientRole ADD MEMBER PatientUser;

-- �������������� ���� �����

-- ����� ��� ���� ������������� (������ ������ �� ���� ��������)
GRANT CONTROL ON DATABASE::�������� TO AdminRole;

-- ����� ��� ���� ����������� �������� (������, �������, ���������� ������)
GRANT SELECT, INSERT, UPDATE ON SCHEMA::dbo TO MedStaffRole;

-- ����� ��� ���� ����������� (���������� � �������� �������)
GRANT SELECT, INSERT ON OBJECT::dbo.������ TO RegistrarRole;

-- ����� ��� ���� ���� (������ � ������ ����� ���������)
GRANT SELECT, UPDATE ON OBJECT::dbo.�������� TO DoctorRole;
GRANT SELECT, UPDATE ON OBJECT::dbo.������ TO DoctorRole;

-- ����� ��� ���� ������� (������������ ������ � ����� ������)
GRANT SELECT ON OBJECT::dbo.�������� TO PatientRole WHERE PatientID = USER_ID();
GRANT SELECT ON OBJECT::dbo.������ TO PatientRole WHERE PatientID = USER_ID();



-- ������ �� �������� ������ ��� ������������ ���������
DENY DELETE ON SCHEMA::dbo TO MedStaffRole;

-- ������ �� ��������� � �������� ��� ������������
DENY UPDATE, DELETE ON OBJECT::dbo.������ TO RegistrarRole;

-- ������ �� ������ � ������ �������� ��� ��������
DENY SELECT ON OBJECT::dbo.����� TO PatientRole;
DENY SELECT ON OBJECT::dbo.�������� TO PatientRole;

-- ����� ������ ��� ������������
ALTER LOGIN AdminLogin WITH PASSWORD = 'NewAdmin@123';

-- ���������� ������������
ALTER LOGIN MedStaffLogin DISABLE;

--  �������� ������������ �� ���� ������
DROP USER RegistrarUser;

-- �������� ������ � �������
DROP LOGIN RegistrarLogin;