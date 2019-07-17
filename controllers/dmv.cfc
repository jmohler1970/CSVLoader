
component	accessors="true"  output="false" {

property	beanFactory;
property	framework;

property dmvService;



void function compress(required struct rc)	{

	param rc.mode = "";

	if (rc.mode != "")	{
		dmvService.setStorage(rc.table, rc.mode);
	}

	if(rc.keyExists("clean"))	{
		dmvService.cleanStorage(rc.clean);
		rc.arMessage.append("<b>Success:</b> Table #rc.trunc# was Cleaned. Fewer pages may be used.");
	}

	if(rc.keyExists("trunc"))	{
		dmvService.truncTable(rc.trunc);
		rc.arMessage.append("<b>Success:</b> Table #rc.trunc# was Truncated. No pages should be used.");
	}

	rc.tblStorage = dmvService.getTblStorage();
}

} // end component


