
<h1>Loading data</h1>

<form action="?" method="post" enctype="multipart/form-data" class="form-inline">
	<div class="form-group">
		<input type="file" name="csv" />
	</div>
	<button type="submit" class="btn btn-primary btn-large">Upload</button>
</form>


<cfoutput>
	<p>Recordcount: <code>#rc.recCount#</code></p>
</cfoutput>

<cfdump var="#rc#">


