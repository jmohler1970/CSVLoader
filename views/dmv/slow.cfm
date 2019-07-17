<h1>Slow Queries</h1>


<p><a href="~/dmv/slow?clear=1" class="btn btn-danger">Clear Plan Cache</a></p>

<p>See: https://stackoverflow.com/questions/2243591/how-to-clear-down-query-execution-statistics-in-sql-server-2005-2008</p>

<cfif rc.keyexists("clear")>

	<cfquery>
		DBCC FREEPROCCACHE
		DBCC DROPCLEANBUFFERS
	</cfquery>
</cfif>


<h2>I/O bound</h2>

<cfquery name="qrySlow">
	SELECT TOP 5
		st.text,
	--	qp.query_plan,
		qs.*,
		qs.total_elapsed_time / Execution_Count AS Ave_Elapsed_Time

	FROM sys.dm_exec_query_stats qs
	CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) st
	CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
	ORDER BY total_logical_reads DESC
</cfquery>



<table class="table table-sm">
<thead>
	<tr>
		<th>Created</th>
		<th>Last Ran</th>
		<th>Executions</th>
		<th class="text-right">Average Elapsed Time</th>
		<th class="text-right">Max Elapsed Time</th>
	</tr>
</thead>
<tbody>
	<cfoutput query="qrySlow">
	<tr class="table-active">
		<td class="text-nowrap">#LSDateFormat(Creation_Time)# @ #LSTimeFormat(Creation_Time)#</td>
		<td class="text-nowrap">#LSDateFormat(Last_Execution_Time)# @ #LSTimeFormat(Last_Execution_Time)#</td>
		<td class="text-right">#(Execution_Count\ 1024)#</td>
		<td class="text-right">#(Ave_Elapsed_Time\ 1024)#</td>
		<td class="text-right">#(Max_Elapsed_Time \ 1024)#</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="4">
			<small>#text#</small>
		</td>
	</tr>
	</cfoutput>
</tbody>
</table>


<h2>CPU bound</h2>

<table class="table table-sm">
<thead>
	<tr>
		<th>Created</th>
		<th>Last Ran</th>
		<th>Executions</th>
		<th class="text-right">Average Elapsed Time</th>
		<th class="text-right">Max Elapsed Time</th>
	</tr>
</thead>
<tbody>
	<cfoutput query="qrySlow">
	<tr class="table-active">
		<td class="text-nowrap">#LSDateFormat(Creation_Time)# @ #LSTimeFormat(Creation_Time)#</td>
		<td class="text-nowrap">#LSDateFormat(Last_Execution_Time)# @ #LSTimeFormat(Last_Execution_Time)#</td>
		<td class="text-right">#(Execution_Count\ 1024)#</td>
		<td class="text-right">#(Ave_Elapsed_Time\ 1024)#</td>
		<td class="text-right">#(Max_Elapsed_Time \ 1024)#</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="4">
			<small>#text#</small>
		</td>
	</tr>
	</cfoutput>
</tbody>
</table>

<h4>Also see</h4>

<ul>
	<li><a href="https://www.sqlpassion.at/archive/2015/04/20/how-to-find-your-worst-performing-sql-server-queries/">https://www.sqlpassion.at/archive/2015/04/20/how-to-find-your-worst-performing-sql-server-queries/</a></li>
</ul>

