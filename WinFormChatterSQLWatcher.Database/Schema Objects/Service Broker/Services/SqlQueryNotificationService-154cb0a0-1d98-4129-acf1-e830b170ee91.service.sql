CREATE SERVICE [SqlQueryNotificationService-154cb0a0-1d98-4129-acf1-e830b170ee91]
    AUTHORIZATION [ChatterUser]
    ON QUEUE [dbo].[SqlQueryNotificationService-154cb0a0-1d98-4129-acf1-e830b170ee91]
    ([http://schemas.microsoft.com/SQL/Notifications/PostQueryNotification]);

