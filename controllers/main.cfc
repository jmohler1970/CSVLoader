
component	accessors="true"  output="false" {

property	beanFactory;
property	framework;

property	textextractService;



// can do searching too
void function home(required struct rc)	{


	if (rc.search != "")	{
		rc.arMessage.append("<b>Info:</b> Searching by <b>#EncodeForHTML(rc.search)#</b>");
	}

	rc.qryCustomers = EntityToQuery(
		ORMExecuteQuery("from Customer WHERE first_name LIKE :name OR last_name LIKE :name ORDER BY first_name",
			{name : rc.search & "%"}, 
			false, 
			{maxresults : 100}
			)
		);
}


void function load(required struct rc)	{

	param rc.dbTable = "Customer";

	if (framework.getCGIRequestMethod() == "post")	{

		var	strPath = "ram://temp/";
		if (!DirectoryExists(strPath)) {
			DirectoryCreate(strPath);
		}


		rc.fileInfo = FileUpload(strPath, "csv", "text/*", "overwrite");

		var csvdata = textextractService.doProcessStruct(strPath & rc.fileInfo.serverFile);

		var iterations = RandRange(1, 100)

		for (var data in csvdata)	{
			EntitySave(EntityNew(rc.dbTable, data));
		}

	}


	rc.recCount = ORMExecuteQuery("select count(*) from Customer")[1];
}


void function clear(required struct rc)	{

	/*
	for (customer in EntityLoad("Customer"))	{
		EntityDelete(customer);
	}
	*/
	ORMExecuteQuery("delete from Customer");

	rc.arMessage.append("Old Data has been removed");

	framework.redirect(".home", "all");
}


void function bootstrap(required struct rc)	{

	param rc.alert = "";

	switch (rc.alert) {
		case "success" : 	
			rc.arMessage.append("<b>Success:</b> Good things have happened. I like to use on POST.");
			break;
		case "warning" : 	
			rc.arMessage.append("<b>Warning:</b> Watch out. This may be a problem, then again the system might just be in an unusual state. I like to use on POST.");
			break;
		case "error" : 	
			rc.arMessage.append("<b>Error:</b> We tried to do something and it did not work. I like to use on POST.");
			break;
		case "info" : 		
			rc.arMessage.append("<b>Info:</b> BTW you might want to be aware of this. I like to use on GET.");
			break;
		case "debug" : 	
			rc.arMessage.append("<b>Info:</b> Debug message are only shown when CF is in debug.");
			rc.arMessage.append("<b>Debug:</b> The system is in debug.");
			break;
	}
}

} // end component
