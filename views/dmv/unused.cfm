<h1>Unused Index</h1>





<cfquery name="qryUnused">
	select object_name(i.object_id) as TableName, i.name as IndexName, MAX(p.rows) AS Rows 
	,8 * SUM(a.used_pages) AS 'Indexsize', 
	s.user_seeks,
	s.user_scans,
	s.user_updates,
	case  
		when i.type = 0 then 'Heap'  
		when i.type= 1 then 'clustered' 
		when i.type=2 then 'Non-clustered'   
		when i.type=3 then 'XML'   
		when i.type=4 then 'Spatial'  
		when i.type=5 then 'Clustered xVelocity memory optimized columnstore index'   
		when i.type=6 then 'Nonclustered columnstore index'  
	end indextype, 
	'DROP INDEX ' + i.name + ' ON ' + object_name(i.object_id) 'Drop Statement' 
	from sys.indexes i 
	left join sys.dm_db_index_usage_stats s on s.object_id = i.object_id 
		and i.index_id = s.index_id 
		and s.database_id = db_id() 
	JOIN sys.partitions AS p ON p.OBJECT_ID = i.OBJECT_ID AND p.index_id = i.index_id 
	JOIN sys.allocation_units AS a ON a.container_id = p.partition_id 
	where objectproperty(i.object_id, 'IsIndexable') = 1 
	AND objectproperty(i.object_id, 'IsIndexed') = 1 
	and s.index_id is null -- and dm_db_index_usage_stats has no reference to this index 
	or (s.user_updates > 0 and s.user_seeks = 0 and s.user_scans = 0 and s.user_lookups = 0)-- index is being updated, but not used by seeks/scans/lookups 
	GROUP BY object_name(i.object_id) ,i.name,i.type,
	 	s.user_seeks, s.user_scans, s.user_updates
	order by object_name(i.object_id) asc
</cfquery>



<table class="table table-sm">
<thead>
	<tr>
		<th>Table</th>
		<th>Index</th>
		<th>Type</th>
		<th class="text-right">Rows</th>
		<th class="text-right">Size</th>
		<th class="text-right">Seeks</th>
		<th class="text-right">Scans</th>
		<th class="text-right">Updates</th>
	</tr>
</thead>

<tbody>
<cfoutput query="qryUnUsed">
	<tr>
		<td>#tableName#</td>
		<td>#indexName#</td>
		<td>#indextype#</td>
		<td class="text-right">#Rows#</td>
		<td class="text-right">#IndexSize#</td>
		<td class="text-right">#user_Seeks#</td>
		<td class="text-right">#user_Scans#</td>
		<td class="text-right">#user_Updates#</td>
	</tr>
</cfoutput>
</tbody>

</table>




<h2>See</h2>

<ul>
	<li>https://www.sqlshack.com/how-to-identify-and-monitor-unused-indexes-in-sql-server/</li>
	<li>https://gallery.technet.microsoft.com/scriptcenter/SQL-How-to-Find-Unused-50c72366</li>
</ul>

