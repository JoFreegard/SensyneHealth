﻿

  --1. -	How many different species of mushroom are there, if a species is identified by the attributes 1-20?
  -- I am using the codes rather than the names because some values do not have a lookup value in the lookup tables and I don't want to lose that data by using the names
  SELECT count (*) AS 'SpeciesCount'
  FROM (
  SELECT DISTINCT [cap-shape-code]
      ,[cap-color-code]
      ,[odor-code]
      ,[gill-size-code]
      ,[gill-color-code]
      ,[stalk-above-ring-color-code]
      ,[veil-color-code]
      ,[ring-type-code]
      ,[spore-print-color-code]
  FROM [Mushrooms].[dbo].[Mushrooms]) x

  --2. -	Does habitat and cap-color correlate?

WITH color_habitat_count AS (
SELECT [cap-shape-code] + [odor-code] + [gill-size-code] + [gill-color-code] + [stalk-above-ring-color-code] + [veil-color-code] + [ring-type-code] + [spore-print-color-code] AS [mushroom-species]
	  ,convert(numeric(18,6),count(distinct [cap-color-code])) AS x
	  ,convert(numeric(18,6),count(distinct [habitat-code])) AS y
  FROM [Mushrooms].[dbo].[mushrooms]
  GROUP BY [cap-shape-code] + [odor-code] + [gill-size-code] + [gill-color-code] + [stalk-above-ring-color-code] + [veil-color-code] + [ring-type-code] + [spore-print-color-code]
  )

 /* get the Perasons r correlation value */
   
SELECT (Avg(x * y) - (Avg(x) * Avg(y))) / (StDevP(x) * StDevP(y)) AS 'Pearsons r'
FROM color_habitat_count




  --3. -	Considering a specific geographical point, what colours should we be able to see in the 10 km around it?
 DECLARE @Origin GEOGRAPHY,
        -- distance in metres
         @Distance INTEGER = 10000;        

-- center point
SET @Origin = GEOGRAPHY::STGeomFromText('POINT(153.685 1.266)', 4326); -- enter geographical point here (format longtitude latitude)

-- return distinct cap colours rows from Mushrooms in 10km radius
SELECT DISTINCT c.[color-name]
FROM [Mushrooms].[dbo].[Mushrooms] m
LEFT JOIN [Mushrooms].[dbo].[color] c
ON m.[cap-color-code] = c.[color-code]
WHERE @Origin.STDistance(geolocation) <= @Distance;
