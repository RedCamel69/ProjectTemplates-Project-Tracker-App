﻿IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [ProjectTasks] (
    [Id] int NOT NULL IDENTITY,
    [Project] nvarchar(max) NOT NULL,
    [Start] datetime2 NOT NULL,
    [End] datetime2 NULL,
    [DateCreated] datetime2 NOT NULL,
    [DateUpdated] datetime2 NULL,
    CONSTRAINT [PK_ProjectTasks] PRIMARY KEY ([Id])
);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20240513124008_initial', N'8.0.4');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ProjectTasks]') AND [c].[name] = N'Project');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [ProjectTasks] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [ProjectTasks] DROP COLUMN [Project];
GO

ALTER TABLE [ProjectTasks] ADD [ProjectId] int NULL;
GO

CREATE TABLE [Projects] (
    [Id] int NOT NULL IDENTITY,
    [Name] nvarchar(max) NOT NULL,
    [DateCreated] datetime2 NOT NULL,
    [DateUpdated] datetime2 NULL,
    [IsDeleted] bit NOT NULL,
    [DateDeleted] datetime2 NULL,
    CONSTRAINT [PK_Projects] PRIMARY KEY ([Id])
);
GO

CREATE INDEX [IX_ProjectTasks_ProjectId] ON [ProjectTasks] ([ProjectId]);
GO

ALTER TABLE [ProjectTasks] ADD CONSTRAINT [FK_ProjectTasks_Projects_ProjectId] FOREIGN KEY ([ProjectId]) REFERENCES [Projects] ([Id]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20240513134059_Projects', N'8.0.4');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [ProjectDetails] (
    [Id] int NOT NULL IDENTITY,
    [Description] nvarchar(max) NULL,
    [StartDate] datetime2 NULL,
    [EndDate] datetime2 NULL,
    [ProjectId] int NOT NULL,
    CONSTRAINT [PK_ProjectDetails] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ProjectDetails_Projects_ProjectId] FOREIGN KEY ([ProjectId]) REFERENCES [Projects] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [Users] (
    [Id] int NOT NULL IDENTITY,
    [Name] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [ProjectUser] (
    [ProjectsId] int NOT NULL,
    [UsersId] int NOT NULL,
    CONSTRAINT [PK_ProjectUser] PRIMARY KEY ([ProjectsId], [UsersId]),
    CONSTRAINT [FK_ProjectUser_Projects_ProjectsId] FOREIGN KEY ([ProjectsId]) REFERENCES [Projects] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_ProjectUser_Users_UsersId] FOREIGN KEY ([UsersId]) REFERENCES [Users] ([Id]) ON DELETE CASCADE
);
GO

CREATE UNIQUE INDEX [IX_ProjectDetails_ProjectId] ON [ProjectDetails] ([ProjectId]);
GO

CREATE INDEX [IX_ProjectUser_UsersId] ON [ProjectUser] ([UsersId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20240513135146_ProjectDetailsAndUsers', N'8.0.4');
GO

COMMIT;
GO

