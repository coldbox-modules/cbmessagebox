/**
 * Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
 * www.ortussolutions.com
 * ---
 * Messagebox configuration
 */
component {

	// Module Properties
	this.title              = "ColdBox MessageBox";
	this.author             = "Luis Majano";
	this.webURL             = "https://www.ortussolutions.com";
	this.description        = "A nice module to produce informative messageboxes leveraging Flash RAM";
	this.version            = "@build.version@+@build.number@";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup   = true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// CF Mapping
	this.cfMapping          = "cbmessagebox";
	// Helpers
	this.applicationHelper  = [ "helpers/mixins.cfm" ];

	/**
	 * Configure Module
	 */
	function configure(){
		settings = {
			// The default template to generate the messagebox with
			// Which receives the binded msgStruct for you to render out
			template      : "/cbmessagebox/views/MessageBox.cfm",
			// If you just want to override styles, then turn this flag on and follow the style guideline
			styleOverride : false,
			// The module root location, internally used
			moduleRoot    : moduleMapping
		};
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
