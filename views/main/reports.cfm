
<h1>Reports</h1>


<h2>State Summary</h2>

<cfscript>
	queryExecute("
		SELECT State, COUNT(*) AS StateCount
		FROM dbo.Customer
		GROUP BY State
		");
</cfscript>
<p>Done</p>



<h2>Postal Code Extremes by state</h2>

<cfscript>
	queryExecute("
		SELECT State, MIN(PostalCode) AS MinPostal, MAX(PostalCode) AS MaxPostal
		FROM dbo.Customer
		GROUP BY State
		");
</cfscript>
<p>Done</p>

<h2>Email Lengths</h2>

<cfscript>
	queryExecute("
		SELECT DISTINCT LEN(Email) AS EmailLen
		FROM dbo.Customer
		ORDER BY EmailLen DESC
		");

</cfscript>
<p>Done</p>

