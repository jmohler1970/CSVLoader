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

<cfquery name="qryMissing">
SELECT
	migs.avg_total_user_cost * (migs.avg_user_impact / 100.0) * (migs.user_seeks + migs.user_scans) AS improvement_measure,
	'CREATE INDEX [missing_index_' + CONVERT (varchar, mig.index_group_handle) + '_' + CONVERT (varchar, mid.index_handle)
	+ '_' + LEFT (PARSENAME(mid.statement, 1), 32) + ']'
	+ ' ON ' + mid.statement
	+ ' (' + ISNULL (mid.equality_columns,'')
	+ CASE WHEN mid.equality_columns IS NOT NULL AND mid.inequality_columns IS NOT NULL THEN ',' ELSE '' END
	+ ISNULL (mid.inequality_columns, '')
	+ ')'
	+ ISNULL (' INCLUDE (' + mid.included_columns + ')', '') AS create_index_statement,
	migs.*, mid.database_id, mid.[object_id]
	FROM sys.dm_db_missing_index_groups mig
	INNER JOIN sys.dm_db_missing_index_group_stats migs ON migs.group_handle = mig.index_group_handle
	INNER JOIN sys.dm_db_missing_index_details mid ON mig.index_handle = mid.index_handle
	WHERE migs.avg_total_user_cost * (migs.avg_user_impact / 100.0) * (migs.user_seeks + migs.user_scans) > 10
	ORDER BY migs.avg_total_user_cost * migs.avg_user_impact * (migs.user_seeks + migs.user_scans) DESC
</cfquery>

<cfdump var="#qryMissing#">


<h1>Also See</h1>

<ul>
	<li>https://blogs.msdn.microsoft.com/bartd/2007/07/19/are-you-using-sqls-missing-index-dmvs/</li>
</ul>
