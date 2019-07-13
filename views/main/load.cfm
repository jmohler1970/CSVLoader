<h1>Loading data</h1>

<form action="?" method="post" enctype="multipart/form-data">
	
	<div class="form-group">
		<div class="form-check">
			<input class="form-check-input" type="radio" name="dbTable" value="customer" <cfif rc.dbTable EQ "customer">checked</cfif> />
			<label class="form-check-label" for="exampleRadios1">
				Customer
			</label>
		</div>

		<div class="form-check">
			<input class="form-check-input" type="radio" name="dbTable" value="interests" <cfif rc.dbTable EQ "interests">checked</cfif> />
			<label class="form-check-label" for="exampleRadios2">
				Interests
			</label>
		</div>
	</div>

	
	<div class="form-group">
		<input type="file" name="csv" />
	</div>


	<button type="submit" class="btn btn-primary btn-large">Upload</button>

	&nbsp;

	<a href="~/home/clear" class="btn btn-danger btn-large">Clear</a>
</form>



<cfdump var="#rc#">