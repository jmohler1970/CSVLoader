
component	accessors="true"  output="false" {

property	beanFactory;
property	framework;

property	textextractService;


void function before(required struct rc)	{
	
}


void function home(required struct rc)	{

	if (framework.getCGIRequestMethod() == "post")	{

		var	strPath = "ram://temp/";
		if (!DirectoryExists(strPath)) {
			DirectoryCreate(strPath);
		}


		rc.fileInfo = FileUpload(strPath, "csv", "text/*", "overwrite");
	}


	//	rc.Customers = EntityLoad("Customer");

	//	rc.Customers2 = ORMExecuteQuery("from Customer");

	rc.recCount = ArrayLen(EntityLoad("Customer"));
}

}
