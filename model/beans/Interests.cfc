component persistent="true" accessors="true" output="false" {

	property name="id" fieldtype="id" generator="identity";

	property name="customer_id";
	property name="genre";
	property name="plant";
	property name="active";
	property name="refunded";
	property name="product";
	property name="cctype";

	property name="CreateDate" update="false" insert="false";
}
