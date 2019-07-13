<h1>Database table compression</h1>




<cfscript>
if (rc.mode != "")	{

	// Don't use this in a production environment
	queryExecute("
		ALTER TABLE Production.TransactionHistory REBUILD PARTITION = ALL  
		WITH (DATA_COMPRESSION = #rc.mode#);
		");

}
</cfscript>

<table class="table table-sm">
<thead>
	<tr>
		<th>Table</th>
		<th>Partition</th>
		<th class="text-right">Used (Kb)</th>
		<th class="text-right">Unused (Kb)</th>
		<th class="text-right">Total (Kb)</th>
		<th class="text-right">Est. None</th>
		<th class="text-right">Est. Row</th>
		<th class="text-right">Est. Page</th>
		<th></th>
	</tr>
</thead>
<tbody>
<cfoutput query="rc.tblStorage">
	<tr>
		<td><code>#SchemaName#.#tableName#</code></td>
		<td>#Partition#</td>
		<td class="text-right">#LSNumberFormat(UsedSpace)#</td>
		<td class="text-right">#LSNumberFormat(UnUsedSpace)#</td>
		<td class="text-right">#LSNumberFormat(TotalSpace)#</td>
		<td class="text-right">#LSNumberFormat(EstNone)#</td>
		<td class="text-right">#LSNumberFormat(EstRow)#</td>
		<td class="text-right">#LSNumberFormat(EstPage)#</td>
		<td>
		<div class="btn-group btn-group-sm" role="group" aria-label="Basic example">
			<a href="~/dmv/compress?table=#EncodeForURL(tableName)#&amp;mode=None" class="btn <cfif compression EQ 'None'>btn-success<cfelse>btn-secondary</cfif> btn-large">None</a>
			<a href="~/dmv/compress?table=#EncodeForURL(tableName)#&amp;mode=Row"  class="btn <cfif compression EQ 'Row'> btn-success<cfelse>btn-secondary</cfif> btn-large">Row</a>
			<a href="~/dmv/compress?table=#EncodeForURL(tableName)#&amp;mode=Page" class="btn <cfif compression EQ 'Page'>btn-success<cfelse>btn-secondary</cfif> btn-large">Page</a>
		</div>
		</td>
	</tr>
</cfoutput>
</tbody>
</table>




<div class="container">
	<div class="row">
		<div class="col-sm"></div>
		<div class="col-sm">


		</div>
		<div class="col-sm"></div>
	</div>
</div>


<p>&nbsp;</p>


<h2>Compression comparision</h2>

<h3>Q: What is this good for?</h3>

<h3>Q: When should use PAGE compression?</h3>

<h3>Q: When should I not use PAGE compression?</h3>

<h3>Q: What do you think of ROW compression?</h3>

<h4>More Info</h4>

<ul>
	<li><a href="https://stackoverflow.com/questions/16988326/query-all-table-data-and-index-compression/21262509#21262509">Stack Overflow</a></li>
</ul>
