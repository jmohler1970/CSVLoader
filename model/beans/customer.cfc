<cfscript>
component persistent="true" accessors="true" output="false" {

	property name="id" fieldtype="id" generator="identity";

	property name="member_id";
	property name="first_Name";
	property name="last_Name";
	property name="Address";
	property name="City";
	property name="State";
	property name="PostalCode";

	property name="Email";
	property name="Phone";
	property name="timezone";
	
	property name="IP";
	property name="app_name";

	property name="CreateDate" update="false" insert="false";
	}
</cfscript>
