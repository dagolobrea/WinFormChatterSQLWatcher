EXECUTE sp_addrolemember @rolename = N'db_owner', @membername = N'ChatterUser';


GO
EXECUTE sp_addrolemember @rolename = N'db_datareader', @membername = N'ChatterUser';


GO
EXECUTE sp_addrolemember @rolename = N'db_datawriter', @membername = N'ChatterUser';

