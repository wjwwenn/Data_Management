use [Global Trade]

-- Delete all Regions from Trade_Partner: 26 seconds
SELECT * FROM Asia_Test
DELETE FROM Asia_Test 
WHERE Trade_Partner IN ('Africa', 'CIS', 'Europe', 'Latin America', 'Middle East', 
'North America', 'Northeast Asia', 'Southeast Asia', 'South Asia', 'Oceania');

-- Delete all Regions from Trade_Partner
SELECT * FROM Europe_Test
DELETE FROM Europe_Test
WHERE Trade_Partner IN ('Africa', 'CIS', 'Europe', 'Latin America', 'Middle East', 
'North America', 'Northeast Asia', 'Southeast Asia', 'South Asia', 'Oceania');

-- Delete all Null values: 39 seconds
SELECT * FROM Asia_Test
UPDATE Asia_Test
SET Year = '' WHERE Year IS NULL;
UPDATE Asia_Test
SET Month = '' WHERE Month IS NULL;
UPDATE Asia_Test
SET Reporter = '' WHERE Reporter IS NULL;
UPDATE Asia_Test
SET Trade_Direction = '' WHERE Trade_Direction IS NULL;
UPDATE Asia_Test
SET Trade_Partner = '' WHERE Trade_Partner IS NULL;
UPDATE Asia_Test
SET Tariff_Line_Code = '' WHERE Tariff_Line_Code IS NULL;
UPDATE Asia_Test
SET Tariff_Line_Description = '' WHERE Tariff_Line_Description IS NULL;
UPDATE Asia_Test
SET Primary_Quantity = '' WHERE Primary_Quantity IS NULL;
UPDATE Asia_Test
SET Primary_Units = '' WHERE Primary_Units IS NULL;
UPDATE Asia_Test
SET ProductKey = '' WHERE ProductKey IS NULL;
UPDATE Asia_Test
SET Product = '' WHERE Product IS NULL;
UPDATE Asia_Test
SET Thousand_Barrels_Per_Day = '' WHERE Thousand_Barrels_Per_Day IS NULL;
UPDATE Asia_Test
SET SubRegion = '' WHERE SubRegion IS NULL;
UPDATE Asia_Test
SET Region = '' WHERE Region IS NULL;
UPDATE Asia_Test
SET No_of_Days = '' WHERE No_of_Days IS NULL;
UPDATE Asia_Test
SET Reporting_Country = '' WHERE Reporting_Country IS NULL;
UPDATE Asia_Test
SET Reporting_Country_Region = '' WHERE Reporting_Country_Region IS NULL;
UPDATE Asia_Test
SET Date = '' WHERE Date IS NULL;

-- Delete all Null values
SELECT * FROM Europe_Test
UPDATE Europe_Test
SET Year = '' WHERE Year IS NULL;
UPDATE Europe_Test
SET Month = '' WHERE Month IS NULL;
UPDATE Europe_Test
SET Reporter = '' WHERE Reporter IS NULL;
UPDATE Europe_Test
SET Trade_Direction = '' WHERE Trade_Direction IS NULL;
UPDATE Europe_Test
SET Trade_Partner = '' WHERE Trade_Partner IS NULL;
UPDATE Europe_Test
SET Tariff_Line_Code = '' WHERE Tariff_Line_Code IS NULL;
UPDATE Europe_Test
SET Tariff_Line_Description = '' WHERE Tariff_Line_Description IS NULL;
UPDATE Europe_Test
SET Primary_Quantity = '' WHERE Primary_Quantity IS NULL;
UPDATE Europe_Test
SET Primary_Units = '' WHERE Primary_Units IS NULL;
UPDATE Europe_Test
SET ProductKey = '' WHERE ProductKey IS NULL;
UPDATE Europe_Test
SET Product = '' WHERE Product IS NULL;
UPDATE Europe_Test
SET Thousand_Barrels_Per_Day = '' WHERE Thousand_Barrels_Per_Day IS NULL;
UPDATE Europe_Test
SET SubRegion = '' WHERE SubRegion IS NULL;
UPDATE Europe_Test
SET Region = '' WHERE Region IS NULL;
UPDATE Europe_Test
SET No_of_Days = '' WHERE No_of_Days IS NULL;
UPDATE Europe_Test
SET Reporting_Country = '' WHERE Reporting_Country IS NULL;
UPDATE Europe_Test
SET Reporting_Country_Region = '' WHERE Reporting_Country_Region IS NULL;
UPDATE Europe_Test
SET Date = '' WHERE Date IS NULL;

-- Union both tables
SELECT * FROM Europe_Test
UNION
SELECT * From Asia_Test
ORDER BY Year, Month, Product;
