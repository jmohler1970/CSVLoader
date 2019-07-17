
<h1>Reports</h1>

<h3>queryExecute</h3>

<p>State Summary</p>

<cfscript>
	queryExecute("
		SELECT State, COUNT(*) AS StateCount
		FROM dbo.Customer
		WHERE member_id IN (SELECT customer_id FROM dbo.Interests)
		GROUP BY State
		");
</cfscript>
<p>Done</p>



<p>Postal Code Extremes by state</p>

<cfscript>
	queryExecute("
		SELECT State, MIN(PostalCode) AS MinPostal, MAX(PostalCode) AS MaxPostal
		FROM dbo.Customer
		WHERE member_id NOT IN (SELECT customer_id FROM dbo.Interests)
		GROUP BY State
		");
</cfscript>
<p>Done</p>

<p>Email Lengths</p>

<cfscript>
	queryExecute("
		SELECT DISTINCT LEN(Email) AS EmailLen, LEN(City) AS CityLen
		FROM dbo.Customer
		ORDER BY EmailLen DESC
		");
</cfscript>
<p>Done</p>


<p>Join on 3 tables</p>
	<cfscript>
	for (i = 1; i < 20; i++)	{

		qryResult = queryExecute("
			SELECT DISTINCT First_name, Last_name, genre, plant_name
			FROM dbo.Interests i 
			INNER JOIN dbo.Plants p ON i.plant = p.plant
			LEFT JOIN dbo.Customer c ON c.id = i.customer_id
			WHERE LEN(i.plant) = ?
			ORDER BY plant_name
			",
			[i]
			);

		}
	</cfscript>

<h3>ORM</h3>

<h4>Customers</h4>
<cfscript>
	for (state in ListToArray("Ohio,Utah,New York"))	{

		customers = EntityLoad("Customer", {state : state});

		writeoutput(ArrayLen(customers) & " records<br />");
		}

</cfscript>


<h4>Interests</h4>
<cfscript>
	interests = EntityLoad("Interests", { refunded : true, cctype : "visa"});

	writedump(interests);

	writeoutput(ArrayLen(interests) & " records<br />");
</cfscript>


<h3>CFQuery</h3>

<h1>Home</h1>


<table class="table" id="example">
<thead>
	<tr>
		<th>Mem. ID</th>
		<th>First Name</th>
		<th>Last Name</th>
		<th>Address</th>
		<th>City</th>
		<th>State</th>
		<th>Postal Code</th>
		<th>Email</th>
		<th>Phone</th>
	</tr>
</thead>
<tbody>
	<cfoutput query="rc.qryCustomers">
	<tr>
		<td>#EncodeForHTML(member_id)#</td>
		<td>#EncodeForHTML(first_Name)#</td>
		<td>#EncodeForHTML(last_Name)#</td>
		<td>#EncodeForHTML(Address)#</td>
		<td>#EncodeForHTML(City)#</td>
		<td>#EncodeForHTML(State)#</td>
		<td>#EncodeForHTML(PostalCode)#</td>
		<td>#EncodeForHTML(Email)#</td>
		<td>#EncodeForHTML(Phone)#</td>
	</tr>
	</cfoutput>
</tbody>
</table>



<script>
$(document).ready(function() {

	$('#example').DataTable({

	});
} );
</script>

<!---
<cfdump var="#rc#">
--->

