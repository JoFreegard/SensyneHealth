/*    
Create the database
*/

USE [master]
GO

/****** Object:  Database [Mushrooms]    Script Date: 24/11/2020 18:10:04 ******/
DROP DATABASE [Mushrooms]
GO

/****** Object:  Database [Mushrooms]    Script Date: 24/11/2020 18:10:04 ******/
CREATE DATABASE [Mushrooms]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Mushrooms', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Mushrooms.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Mushrooms_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Mushrooms_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO


/*    
Create the tables and populate them
*/
USE [Mushrooms]
GO

DROP TABLE [dbo].[cap-shape]
GO

CREATE TABLE [dbo].[cap-shape](
	[cap-shape-code] [char](1) NOT NULL,
	[cap-shape-name] [varchar](20) NULL,
 CONSTRAINT [PK_cap-shape] PRIMARY KEY CLUSTERED ([cap-shape-code] ASC)
) 
GO

 
 INSERT INTO [dbo].[cap-shape] ([cap-shape-code], [cap-shape-name])
 VALUES 
 ('b', 'bell'),
 ('c', 'conical'),
 ('x', 'convex'),
 ('f', 'flat'),
 ('k', 'knobbed'),
 ('s', 'sunken')

 DROP TABLE [dbo].[color]

 CREATE TABLE [dbo].[color] (
 [color-code] char(1) NOT NULL,
 [color-name] varchar(20) NULL,
 CONSTRAINT [PK_color] PRIMARY KEY CLUSTERED ([color-code] ASC)
) 
 

 INSERT INTO [dbo].[color] ([color-code], [color-name])
 VALUES 
 ('n', 'brown'),
 ('b', 'buff'),
 ('c', 'cinnamon'),
 ('g', 'gray'),
 ('r', 'green'),
 ('p', 'pink'),
 ('u', 'purple'),
 ('e', 'red'),
 ('w', 'white'),
 ('y', 'yellow'),
 ('k', 'black'),
 ('h', 'chocolate'),
 ('o', 'orange')

 DROP TABLE [dbo].[odor]

 CREATE TABLE [dbo].[odor] (
 [odor-code] char(1) NOT NULL,
 [odor-name] varchar(20) NULL,
 CONSTRAINT [PK_odor] PRIMARY KEY CLUSTERED ([odor-code] ASC)
) 
  
 INSERT INTO [dbo].[odor] ([odor-code], [odor-name])
 VALUES 
 ('a', 'almond'),
 ('l', 'anise'),
 ('c', 'creosote'),
 ('y', 'fishy'),
 ('f', 'foul'),
 ('m', 'musty'),
 ('n', 'none'),
 ('p', 'pungent'),
 ('s', 'spicy')

 DROP TABLE [dbo].[gill-size]

 CREATE TABLE [dbo].[gill-size] (
 [gill-size-code] char(1) NOT NULL,
 [gill-size-name] varchar(20) NULL,
 CONSTRAINT [PK_gill-size] PRIMARY KEY CLUSTERED ([gill-size-code] ASC)
) 

 INSERT INTO [dbo].[gill-size] ([gill-size-code], [gill-size-name])
 VALUES 
 ('b', 'broad'),
 ('n', 'narrow')

 DROP TABLE [dbo].[ring-type]

 CREATE TABLE [dbo].[ring-type] (
 [ring-type-code] char(1) NOT NULL,
 [ring-type-name] varchar(20) NULL,
 CONSTRAINT [PK_ring-type] PRIMARY KEY CLUSTERED ([ring-type-code] ASC)
) 

 INSERT INTO [dbo].[ring-type] ([ring-type-code], [ring-type-name])
 VALUES 
 ('c', 'cobwebby'),
 ('e', 'evanescent'),
 ('f', 'flaring'),
 ('l', 'large'),
 ('n', 'none'),
 ('p', 'pendant'),
 ('s', 'sheathing'),
 ('z', 'zone')

 DROP TABLE [dbo].[population]

 CREATE TABLE [dbo].[population] (
 [population-code] char(1) NOT NULL,
 [population-name] varchar(20) NULL,
 CONSTRAINT [PK_population] PRIMARY KEY CLUSTERED ([population-code] ASC)
) 

 INSERT INTO [dbo].[population] ([population-code], [population-name])
 VALUES 
 ('a', 'abundant'),
 ('c', 'clustered'),
 ('n', 'numerous'),
 ('s', 'scattered'),
 ('v', 'several'),
 ('y', 'solitary')

 DROP TABLE [dbo].[habitat]

 CREATE TABLE [dbo].[habitat] (
 [habitat-code] char(1) NOT NULL,
 [habitat-name] varchar(20) NULL,
 CONSTRAINT [PK_habitat] PRIMARY KEY CLUSTERED ([habitat-code] ASC)
) 

 INSERT INTO [dbo].[habitat] ([habitat-code], [habitat-name])
 VALUES 
 ('g', 'grasses'),
 ('l', 'leaves'),
 ('m', 'meadows'),
 ('p', 'paths'),
 ('u', 'urban'),
 ('w', 'waste'),
 ('d', 'woods')

 DROP TABLE [dbo].[mushrooms]

 CREATE TABLE [dbo].[mushrooms] (
 [cap-shape-code] char(1) NOT NULL,
 [cap-color-code] char(1) NOT NULL,
 [odor-code] char(1) NOT NULL,
 [gill-size-code] char(1) NOT NULL,
 [gill-color-code] char(1) NOT NULL,
 [stalk-above-ring-color-code] char(1) NOT NULL,
 [veil-color-code] char(1) NOT NULL,
 [ring-type-code] char(1) NOT NULL,
 [spore-print-color-code] char(1) NOT NULL,
 [population-code] char(1) NOT NULL,
 [habitat-code] char(1) NOT NULL,
 [latitude] float,
 [longitude] float,
 [geolocation] AS geography::STPointFromText('POINT(' + CAST([longitude] AS VARCHAR(20)) + ' ' + 
                    CAST([latitude] AS VARCHAR(20)) + ')', 4326),
 [time] time(0)
 )


