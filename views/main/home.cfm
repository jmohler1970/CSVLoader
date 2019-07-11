
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

