component {

	// Module Properties
	this.title 				= "MessageBox";
	this.author 			= "Luis Majano";
	this.webURL 			= "http://www.ortussolutions.com";
	this.description 		= "A nice module to produce informative messageboxes leveraging Flash RAM";
	this.version			= "1.0.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "MessageBox";

	function configure(){

		// module settings - stored in modules.name.settings
		settings = {
			// The template to use to render out the messagebox
			template = "#moduleMapping#/views/MessageBox.cfm",
			// Override the messagebox styles?
			styleOverride = false
		};

		// Binder Mappings
		binder.map( "MessageBox@MessageBox" ).to( "#moduleMapping#.model.MessageBox" );

	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){

	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){

	}

}