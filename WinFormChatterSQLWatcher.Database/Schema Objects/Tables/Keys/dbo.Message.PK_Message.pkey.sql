﻿ALTER TABLE [dbo].[Message]
    ADD CONSTRAINT [PK_Message] PRIMARY KEY CLUSTERED ([int] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);

