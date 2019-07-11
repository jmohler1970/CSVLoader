<h1>Missing Index</h1>


<p>What is this good for? If your database is missing an index it can mean that adding an index, or altering an index will improve performance.</p>

<p>Please test in an appropriate environment before committing a change to the indexing. Some real quick thoughts on indexing:</p>

<ul>
	<li>Adding an index does not always make selects faster</li>
	<li>This missing index dmv will make conflicting recommendations on the same table. Look at all of them</li>
	<li>INSERTs, UPDATEs, and DELETEs will almost always be slower. But it so small as to not be measurable</li>
	<li>Using compressing on a table might be better solution.</li>
	<li>Speaking of compressing, making an indexed compressed is often a good idea.</li>
</ul>

<cfsavecontent variable="sql">

</cfsavecontent>

<cfoutput>
<pre>#sql#</pre>
</cfoutput>



<h1>Also See</h1>


