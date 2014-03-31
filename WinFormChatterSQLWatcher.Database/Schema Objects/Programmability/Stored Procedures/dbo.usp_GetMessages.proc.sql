CREATE PROC [dbo].[usp_GetMessages]

AS

SELECT [Message], [Name]
FROM dbo.[Message]
JOIN dbo.Person ON id = [Message].Person_ID