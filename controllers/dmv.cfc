
component	accessors="true"  output="false" {

property	beanFactory;
property	framework;

property dmvService;



void function compress(required struct rc)	{

	param rc.mode = "";

	rc.tblStorage = dmvService.getTblStorage();
}

} // end component
