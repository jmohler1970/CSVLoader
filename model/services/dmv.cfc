component 	{


query function getTblStorage()	{

	var qryResult = queryExecute("
		SELECT 
			s.Name AS SchemaName,
			t.NAME AS TableName,
			p.partition_number AS Partition,
			p.rows AS RowCounts,
			p.data_compression_desc AS Compression,
	
			SUM(a.total_pages) * 8 AS TotalSpace, 
			SUM(a.used_pages) * 8 AS UsedSpace, 
			(SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpace,
			0 AS EstNone,
			0 AS EstRow,
			0 AS EstPage 

		FROM 
			sys.tables t
		INNER JOIN      
			sys.indexes i ON t.OBJECT_ID = i.object_id
		INNER JOIN 
			sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
		INNER JOIN 
			sys.allocation_units a ON p.partition_id = a.container_id
		LEFT OUTER JOIN 
			sys.schemas s ON t.schema_id = s.schema_id
		WHERE 
			t.NAME NOT LIKE 'dt%' 
		AND t.is_ms_shipped = 0
		AND i.OBJECT_ID > 255 
		GROUP BY 
			t.Name, s.Name, p.Rows, p.partition_number, p.data_compression_desc
		ORDER BY 
			t.Name
	");

	for (var row = 1; row <= qryResult.recordCount; row++)	{
		qryResult.setCell("EstNone", getEstStorage(qryResult.TableName[row], 'None'));
		qryResult.setCell("EstRow",  getEstStorage(qryResult.TableName[row], 'Row' ));
		qryResult.setCell("EstPage", getEstStorage(qryResult.TableName[row], 'Page'));
	}

	return qryResult
}

private string function getEstStorage(required string tableName, required string mode) hint="don't use this in producton"	{


	return queryExecute("
		EXEC sp_estimate_data_compression_savings 'dbo', ?, NULL, NULL, ?; 
		",
		[arguments.tableName, arguments.mode]
		)['SIZE_WITH_REQUESTED_COMPRESSION_SETTING(KB)'][1];

}



} // end component

