CREATE TABLE [dbo].[Message] (
    [int]       BIGINT         IDENTITY (1, 1) NOT NULL,
    [Message]   NVARCHAR (200) NOT NULL,
    [Person_ID] INT            NOT NULL
);

