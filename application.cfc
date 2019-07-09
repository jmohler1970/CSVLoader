<cfscript>
component extends="framework.one" output="false"	{


this.name					= "csv_cf_001";
this.applicationTimeout 		= createTimeSpan(0, 4, 0, 0);
this.applicationManagement 	= true;
this.ormenabled = true;
this.datasource = "CSVLoader"; // Reddog1

this.mappings = {
	"/models"	= GetDirectoryFromPath(getBaseTemplatePath()) & "models/"
	};

variables.framework	=	{
	home			= "main.home",
	baseURL		= 'useCGIScriptName',
	defaultItem	= "home",
	generateSES	= true,
	SESomitIndex	= false,
	decodeRequestBody = false, // REST
	trace 		= false
	};


function setupApplication() output="false"	{


	application.initialized = now();


	application.GSROOTPATH			= getdirectoryfrompath(getBaseTemplatePath());
	application.GSDATAPATH			= application.GSROOTPATH & "data/";
	}
}
</cfscript>
