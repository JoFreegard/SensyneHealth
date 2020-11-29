

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
-- using color name we get a lot of rows returned with a null color
-- probably best to use colour code as we get more meaningful data then, assuming somebody can tell us what those color codes mean

  SELECT *
  FROM
  (SELECT [habitat-name], [color-name], 1 AS [count-mushrooms]
  FROM dbo.mushrooms m
  LEFT JOIN dbo.habitat h
  ON m.[habitat-code] = h.[habitat-code]
  LEFT JOIN dbo.color c
  ON m.[cap-color-code] = c.[color-code]
  ) AS SourceTable
  PIVOT
  (sum([count-mushrooms])
  FOR [habitat-name] IN ([woods],[grasses],[leaves],[meadows],[paths],[urban],[waste])
  ) AS PivotTable

  SELECT *
  FROM
  (SELECT [habitat-name], [cap-color-code], 1 AS [count-mushrooms]
  FROM dbo.mushrooms m
  LEFT JOIN dbo.habitat h
  ON m.[habitat-code] = h.[habitat-code]
  ) AS SourceTable
  PIVOT
  (sum([count-mushrooms])
  FOR [habitat-name] IN ([woods],[grasses],[leaves],[meadows],[paths],[urban],[waste])
  ) AS PivotTable




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