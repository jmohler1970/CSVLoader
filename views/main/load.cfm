<h1>Loading data</h1>

<form action="?" method="post" enctype="multipart/form-data" class="form-inline">
	<div class="form-group">
		<input type="file" name="csv" />
	</div>
	<button type="submit" class="btn btn-primary btn-large">Upload</button>

	&nbsp;

	<a href="~/home/clear" class="btn btn-danger btn-large">Clear</a>
</form>



<cfdump var="#rc#">