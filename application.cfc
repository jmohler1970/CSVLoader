<cfscript>
component extends="framework.one" output="false"	{


this.name					= "csv_cf_001";
this.applicationTimeout 		= createTimeSpan(0, 4, 0, 0);
this.applicationManagement 	= true;
this.ormenabled = true;
this.datasource = "CSVLoader"; // Reddog1
this.invokeImplicitAccessor = true;
this.enableNullSupport = true;

this.serialization.preservecaseforstructkey = true;
this.serialization.serializeQueryAs = "struct";

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



	application.showMessage = function(required array arMessage) output="false" {

		var strMessage = "<!-- Start of message queue -->";

		var messageFormat = [
			"success" : { "icon" : "fas fa-2x fa-check-circle text-success", 		"alert" : "alert alert-success" 	},
			"info" 	: { "icon" : "fas fa-2x fa-info-circle text-info", 			"alert" : "alert alert-info" 		},
			"warning" : { "icon" : "fas fa-2x fa-exclamation-triangle text-warning", 	"alert" : "alert alert-warning" 	},
			"error" 	: { "icon" : "fas fa-2x fa-bomb text-danger", 				"alert" : "alert alert-danger" 	},
			"debug" 	: { "icon" : "fas fa-2x fa-bug text-danger", 				"alert" : "alert alert-danger" 	}
		];

		for(local.i in arguments.arMessage)	{

			var mode = "";
			if (local.i CONTAINS "success")		mode = "success";
			if (local.i CONTAINS "warning")		mode = "warning";
			if (local.i CONTAINS "error") 		mode = "error";
			if (left(local.i, 20) CONTAINS "info")	mode = "info";
			if (local.i CONTAINS "debug")	{
				if (isdebugmode() || cgi.http_host CONTAINS "beta")	{
					mode = "debug";
				}
			}

			strMessage &= '<div class="row">';
			strMessage &= '<div class="col"></div>';
			strMessage &= '<div class="col-sm-6">';


			if (local.i != "" && mode != "")	{

				strMessage &= '<div class="#messageFormat[mode].alert#">';
				strMessage &= '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>';
				strMessage &= '<div class="row">';
				strMessage &= '<div class="col-sm-2 col-lg-1"><i class="#messageFormat[mode].icon#"></i></div>';
				strMessage &= '<div class="col-sm-10 col-lg-11">#local.i#</div>';
				strMessage &= '</div><!--/ row -->';
				strMessage &= '</div>';
				}


			strMessage &= '</div>';
			strMessage &= '<div class="col"></div>';
			strMessage &= '</div>';
			} // end for


		return strMessage & "<!-- end of message queue -->";
	};



	application.GSROOTPATH			= getdirectoryfrompath(getBaseTemplatePath());
	application.GSDATAPATH			= application.GSROOTPATH & "data/";
	}


function before()	{

	param rc.search = "";

	param rc.arMessage = []; // due to redirect, this may already exist
}

}
</cfscript>
