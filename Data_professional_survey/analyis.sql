/* 

Queries for the Power BI

*/

-- see details of the table from to understand the data 
SELECT * FROM ['Data Professional Survey$']

  
SELECT
	[Unique ID],
	UPPER(REPLACE ([Q11 - Which Country do you live in?], 'Other (Please Specify):','')) AS Country,
	REPLACE ([Q1 - Which Title Best Fits your Current Role?], 'Other (Please Specify):','') AS 'Job Title',
	[Q2 - Did you switch careers into Data?],
	REPLACE(
		LEFT([Q3 - Current Yearly Salary (in USD)],
		CASE
		WHEN CHARINDEX('-',[Q3 - Current Yearly Salary (in USD)]) = 0 THEN LEN([Q3 - Current Yearly Salary (in USD)])
		ELSE CHARINDEX('-', [Q3 - Current Yearly Salary (in USD)]) - 1
		END),
		'k', ''	) AS lowerband, 
	REPLACE(
		REPLACE(
			SUBSTRING(
				[Q3 - Current Yearly Salary (in USD)],
				(CHARINDEX('-', [Q3 - Current Yearly Salary (in USD)])+1), 
				(LEN([Q3 - Current Yearly Salary (in USD)]) - CHARINDEX('-', [Q3 - Current Yearly Salary (in USD)]))), 'k', ''
		), '+', ''
	) AS Upperband,
	(CAST(REPLACE(
			REPLACE(
				LEFT([Q3 - Current Yearly Salary (in USD)],
				CASE
				WHEN CHARINDEX('-',[Q3 - Current Yearly Salary (in USD)]) = 0 THEN LEN([Q3 - Current Yearly Salary (in USD)])
				ELSE CHARINDEX('-', [Q3 - Current Yearly Salary (in USD)]) - 1
				END),
				'k', ''	), '+', '') AS INT) +
	CAST(REPLACE(
		REPLACE(
		SUBSTRING(
			[Q3 - Current Yearly Salary (in USD)],
			(CHARINDEX('-', [Q3 - Current Yearly Salary (in USD)])+1), 
			(LEN([Q3 - Current Yearly Salary (in USD)]) - CHARINDEX('-', [Q3 - Current Yearly Salary (in USD)]))), 'k', ''
		), '+', '') AS INT)
	)/2 AS 'Salary (USD)',
	REPLACE ([Q4 - What Industry do you work in?], 'Other (Please Specify):','') AS Sector,
	[Q5 - Favorite Programming Language] AS 'Programming Language',
	[Q6 - How Happy are you in your Current Position with the follow1],
	[Q6 - How Happy are you in your Current Position with the follow2],
	[Q6 - How Happy are you in your Current Position with the follow3],
	[Q6 - How Happy are you in your Current Position with the follow4],
	[Q6 - How Happy are you in your Current Position with the follow5],
	[Q6 - How Happy are you in your Current Position with the followi],
	[Q7 - How difficult was it for you to break into Data?],
	[Q9 - Male/Female?] AS Sex,
	[Q10 - Current Age] AS Age
FROM ['Data Professional Survey$']
