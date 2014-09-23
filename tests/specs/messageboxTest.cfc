<!-----------------------------------------------------------------------
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************
----------------------------------------------------------------------->
<cfcomponent extends="coldbox.system.testing.BaseTestCase" appmapping='/root'>

	<cffunction name="setUp" returntype="void" access="public" output="false">
		<cfscript>
		//Call the super setup method to setup the app.
		super.setup();
		</cfscript>
	</cffunction>

	<cffunction name="testObject" access="public" returntype="void" output="false">
		<!--- Now test some events --->
		<cfscript>
			var model = getWireBox().getInstance("MessageBox@messagebox");

			AssertTrue( isObject(model) );

		</cfscript>
	</cffunction>

	<cffunction name="testMethods" access="public" returntype="void" output="false">
		<!--- Now test some events --->
		<cfscript>
			var messages = "";

			/* get Plugin */
			var model = getWireBox().getInstance("MessageBox@messagebox");

			/* Set Message */
			model.setMessage("info","TestMessage");
			AssertEquals( model.getMessage().message, "TestMessage", "Set and Get.");
			AssertFalse( model.isEmptyMessage(), "Empty Test");

			/* Append */
			model.append("pio");
			AssertEquals( model.getMessage().message, "TestMessagepio", "Append Test");

			/* Append an array */
			messages = "unit test";
			model.appendArray(listToArray(messages));

			/* Clear */
			model.clearMessage();
			AssertEquals( model.getMessage().message, "", "Clear first, then get test.");
			AssertTrue( model.isEmptyMessage(), "Empty Test");

			/* Append on empty */
			model.append("pio");
			AssertEquals( model.getMessage().message, "pio", "Append on empty Test");
			model.clearMessage();

			/* Append on empty Array */
			messages = "unit test";
			model.appendArray(listToArray(messages));
			AssertEquals( model.getMessage().message, "unit test", "Append on Empty");


			/* Set Array Message */
			messages = "Hello, This is a test, Hello World";

			model.setMessage("info","",listToArray(messages) );
			AssertTrue( model.getMessage().message.length() neq 0," Array of messages set.");
			AssertFalse( model.isEmptyMessage(), "Empty Test");

			/* Final Render */
			AssertTrue( model.renderit().length() neq 0, " Render message");

			/* Clear */
			model.clearMessage();
		</cfscript>
	</cffunction>

</cfcomponent>