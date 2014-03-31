CREATE PROC [dbo].[usp_InsertMessage]
	@Message nvarchar(200),
	@Person_ID int
AS

INSERT INTO [Message] ([Message], Person_ID)
VALUES (@Message, @Person_ID)
