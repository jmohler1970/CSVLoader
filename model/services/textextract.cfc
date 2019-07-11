component output="false"  {

variables.delimiter = "";
variables.fixedLen	= "";
variables.fileObj = "";


array function doProcess(required string fileToProcess, array fixedLen = []) output="false" {

	// Returns arrays of arrays
	// Or arrays of ordered structs


	var bContinue = true;
	var aResult = ArrayNew['array'](1);

	this.setup(arguments.fileToProcess, arguments.fixedLen);

	while(bContinue)	{
		var myLine = this.getNextLineTokens();

		if(myLine.isEmpty())	{
			return aResult;
		}
	
		aResult.append(myLine);
	}

	return aResult;
}


array function doProcessStruct(required string fileToProcess, array fixedLen = []) output="false" {

	// Returns arrays of arrays
	// Or arrays of ordered structs


	var bContinue = true;
	var aResult = ArrayNew['struct'](1);

	this.setup(arguments.fileToProcess, arguments.fixedLen);

	var header = this.getNextLineTokens();

	while(bContinue)	{
		var myLine = this.getNextLineTokens();

		if(myLine.isEmpty())	{
			return aResult;
		}

		var colcount = 0;
		var stLine = [:];

		for (col in header)	{
			colcount++;
			stLine[col] = myLine[colcount];
		}


		aResult.append(stLine);
	}

	return aResult;
}


boolean function setup(required string fileToProcess, array fixedLen = []) output="false" hint="This does not do full file processing." {

	if(!FileExists(arguments.fileToProcess))	{
		return false; // no need to continue
		}


	variables.fileObj = FileOpen(arguments.fileToProcess); // We are going to keep this around because we don't want to have the os reprocess the file

	local.fileExtDelim = "."; // as opposed to all the other uses for a dot

	switch(arguments.fileToProcess.listlast(local.fileExtDelim))	{
		case "tab"	: variables.delimiter = Chr(9); 	break; // otherwise known as a tab. Some editors change tabs to spaces. This is prevent that
		case "csv"	: variables.delimiter = ",";		break; // Comma separated values
		case "pipe"	: variables.delimiter = "|";		break; // Pipe separated values
		case "fixed"	: variables.delimiter = "fixed";	break; // Fixed delimited uses an array of lengths to find fields
		default 		: variables.delimiter = "unknown"; return false; break;
		}

	if (variables.delimiter == "fixed")	{ // We are going to need to patch the cutoff points
		variables.fixedLen		= arguments.fixedLen;

		variables.fixedLen = [1]; // points to first character on a line
		for (local.position in arguments.fixedLen)	{
			// we are going to append the positions into a more workable array
			variables.fixedLen.append(variables.fixedLen[variables.fixedLen.len()] + local.position);
			}
		}

	return true;
	}


array function getNextLineTokens() output="false"	{

	if(FileisEOF(variables.fileObj)) {
		return [];
		}

	if(variables.delimiter == "fixed")	{
		local.currentLine = FileReadLine(variables.fileObj);
		local.result = [];
		for (local.index = 1; local.index < variables.fixedLen.Len(); local.index++)	{
			local.result.append(
				local.currentLine.mid(variables.fixedLen[local.index], variables.fixedLen[local.index + 1])
				);
			} // end for

		return local.result;
		} // end fixed

	return FileReadLine(variables.fileObj).ListToArray(variables.delimiter);
	}

}