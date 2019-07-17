<h1>Database Storage</h1>






<table class="table table-sm">
<thead>
	<tr>
		<th>Table</th>
		<th>Part.</th>
		<th>Rows</th>
		<th class="text-right">Used Pages</th>
		<th class="text-right">Unused Pages</th>
		<th class="text-right">Total Pages</th>
		<th class="text-right">Est. None</th>
		<th class="text-right">Est. Row</th>
		<th class="text-right">Est. Page</th>
		<th></th>
		<th></th>
		<th></th>
		<th></th>
	</tr>
</thead>
<tbody>
<cfoutput query="rc.tblStorage">
	<tr>
		<td><code>#SchemaName#.#tableName#</code></td>
		<td>#Partition#</td>
		<td class="text-right">#LSNumberFormat(RowCounts)#</td>
		<td class="text-right">#LSNumberFormat(UsedSpace)#</td>
		<td class="text-right">#LSNumberFormat(UnUsedSpace)#</td>
		<td class="text-right">#LSNumberFormat(TotalSpace)#</td>
		<td class="text-right">#LSNumberFormat(EstNone)#</td>
		<td class="text-right">#LSNumberFormat(EstRow)#</td>
		<td class="text-right">#LSNumberFormat(EstPage)#</td>
		<td>
		<div class="btn-group btn-group-sm" role="group" aria-label="Basic example">
			<a href="~/dmv/compress?table=#EncodeForURL(tableName)#&amp;mode=None" class="btn <cfif compression EQ 'None'>btn-success<cfelse>btn-secondary</cfif>">None</a>
			<a href="~/dmv/compress?table=#EncodeForURL(tableName)#&amp;mode=Row"  class="btn <cfif compression EQ 'Row'> btn-success<cfelse>btn-secondary</cfif>">Row</a>
			<a href="~/dmv/compress?table=#EncodeForURL(tableName)#&amp;mode=Page" class="btn <cfif compression EQ 'Page'>btn-success<cfelse>btn-secondary</cfif>">Page</a>
		</div>
		</td>
		<td>
			<a href="~/dmv/compress?clean=#EncodeForURL(tableName)#" class="btn btn-warning btn-sm" title="Clean and Release"><i class="fas fa-recycle"></i></a>
		</td>

		<td>
			<a href="~/dmv/compress?trunc=#EncodeForURL(tableName)#" class="btn btn-danger btn-sm" title="Truncate"><i class="fas fa-trash"></i></a>
		</td>

		<td>
			<a href="~/main/load?dbtable=#EncodeForURL(tableName)#" class="btn btn-success btn-sm" title="Upload"><i class="fas fa-upload"></i></a>
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


<h2>Compression FAQ</h2>

<p><b>Q:</b> What is this good for?</p>

<p><b>A:</b> All kinds of things</p>

<ul>
	<li>If you have tables with a lot of redundant data, compression can reduce the storage needs</li>
	<li>Depending on the data it can be anywhere from slightly small, to a 10 to 1 ratio. As a rule of thumb, I use compression if I get a 3 to 1 ratio</li>
	<li>It can also remove the need for indexes. Because the data takes less physicial space, queries against it will, in general, be faster.</li>
</ul>

<p>&nbsp;</p>

<p><b>Q:</b> What does it do?</p>

<p><b>A:</b> For ROW compression, if there is redundant data in a row, only one copy is saved. All the other columns just have pointers to the first copy. Hence each row takes less space.</p>


<p><b>A:</b> For PAGE compression, three things are done.</p>

<ol>
	<li>ROW compression is done</li>
	<li>If there are values, that start the same, but end different, the common part will be compressed. My favorite example of this is saving User Agent Strings (Browser Info). Most browsers start with <q>Mozilla</q> but the rest varies. This is called prefix compression</li>
	<li>If multiple rows have the same values, only one copy is saved. All the other columns just have pointers to the first copy. This is called dictionary compression</li>
</ol>

<p>See: https://docs.microsoft.com/en-us/sql/relational-databases/data-compression/page-compression-implementation?view=sql-server-2017</p>



<p><b>Q:</b> When should I use PAGE compression as opposed to ROW compression?</p>

<p><b>A:</b> PAGE compression should be almost all the time. Please check your results to confirm that you are getting what you think you should get.</p>

<p>&nbsp;</p>




<p><b>Q:</b> Can I compress an existing table?</p>

<p><b>A:</b> Yes, but... You may end of with table that takes up more physical space. That seems kind of strange, When you change the storage model. </p>

<p>&nbsp;</p>


<p><b>Q:</b> What my data is not compressable and I set it to be compressed. Is this bad?</p>

<p><b>A:</b> Not really. If you data cannot be compressed, it just won't be. If won't take more space. Nor will it take more CPU time.</p>

<p>&nbsp;</p>

<p><b>Q:</b> Can I un compress an existing table?</p>

<p><b>A:</b> Yes. Make sure to check the unused space on your table. You may find that you table grew in storage needs much more than expected.</p>

<p>&nbsp;</p>


<p><b>Q:</b> Do I have change any of my ColdFusion code when I use compressed tables?</p>

<p><b>A:</b> No</p>


<hr />

<p><b>Q:</b> What about SPARSE fields?</p>

<p><b>A:</b> SPARSE fields are a different approach making storage more efficient. It's approach is something like this.</p>

<ul>
	<li>If you have a data in a column that is null, store the null. Furthure more don't allocate any space on the PAGE ever. Because space is not allocated by default, the table is smaller. If you are searching and your WHERE clause is using IS NULL or IS NOT NULL, it is really fast.</li>
	<li>If you have data that is not null, store the data in the EXTENTS region. Slightly more space will be allocated because storage approach requires it. As a result, the data will be slightly bigger. If you are searching and your WHERE or JOIN references this data, it will be slower. It can be significally slower.</li>
</ul>

<p>So what is the moral of the story, only use SPARCE on fields that are usually null and don't participate in filtering or joining. Unless the filtering is on NULL-ness.</p>

<p>See: https://stackoverflow.com/questions/1398453/why-when-should-i-use-sparse-column-sql-server-2008</p>

<p>&nbsp;</p>

<p><b>Q:</b> So how does SPARSE with worth compression?</p>

<p><b>A:</b> They don't work together. Compression is much more agressive than SPARSE. SPARSE works with nulls, Compression works with everything including nulls. On the other hand, SPARSE is easy for the DB to figure out. It might be quicker.</p>

<p>&nbsp;</p>


<p><b>Q:</b> Do I have change any of my ColdFusion code when I use SPARSE?</p>

<p><b>A:</b> No</p>



<h4>More Info</h4>

<ul>
	<li><a href="https://stackoverflow.com/questions/16988326/query-all-table-data-and-index-compression/21262509#21262509">Stack Overflow</a></li>
</ul>
