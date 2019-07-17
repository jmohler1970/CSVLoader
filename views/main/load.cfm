<h1>Loading data</h1>

<form action="?" method="post" enctype="multipart/form-data">
	
	<div class="form-group">
		<div class="form-check">
			<input class="form-check-input" type="radio" name="dbTable" value="customer" <cfif rc.dbTable EQ "customer">checked</cfif> />
			<label class="form-check-label" for="exampleRadios1">
				<code>dbo.Customer</code>
			</label>
		</div>

		<div class="form-check">
			<input class="form-check-input" type="radio" name="dbTable" value="interests" <cfif rc.dbTable EQ "interests">checked</cfif> />
			<label class="form-check-label" for="exampleRadios2">
				<code>dbo.Interests</code>
			</label>
		</div>

		<div class="form-check">
			<input class="form-check-input" type="radio" name="dbTable" value="plants" <cfif rc.dbTable EQ "plants">checked</cfif> />
			<label class="form-check-label">
				<code>dbo.Plants</code>
			</label>
		</div>
		
		<div class="form-check">
			<input class="form-check-input" type="radio" name="dbTable" value="plants_sparse" <cfif rc.dbTable EQ "plants_sparse">checked</cfif> />
			<label class="form-check-label">
				<code>dbo.Plants_Sparse</code>
			</label>
		</div>
	</div>

	
	<div class="form-group">
		<input type="file" name="csv" required />
	</div>


	<button type="submit" class="btn btn-primary btn-large">Upload</button>

	&nbsp;

	<a href="~/home/clear" class="btn btn-danger btn-large">Clear</a>
</form>


<p>&nbsp;</p>


<cfif rc.keyExists("fileinfo")>

	<table class="table table-sm">
	<cfloop list="#rc.fileinfo.keyList()#" item="item">
		<cfoutput>
		<tr>
			<th>#item#</th>
			<td>#rc.fileinfo[item]#</td>
		</tr>
		</cfoutput>
	</cfloop>
	</table>
</cfif>

