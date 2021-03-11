<cfscript>
	/**
	 * Get access to the messagebox object
	 */
	function cbMessageBox() {
		if( isNull( variables._cbMessagebox ) ){
			variables._cbMessagebox = variables.wirebox.getInstance( "messagebox@cbmessagebox" );
		}
    	return variables._cbMessagebox;
    }
</cfscript>