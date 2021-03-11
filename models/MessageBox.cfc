/**
 * Copyright Since 2005 Ortus Solutions, Corp
 * www.ortussolutions.com
 * ---
 * @author Luis Majano
 *
 * This module provides a way to track alert message boxes.  The user has several types of message types
 * 1. Warn
 * 2. Error
 * 3. Info
 * 4. Success
 * The messages and optional metadata will be stored in the application's Flash RAM storage.
 * The look and feel of the messages can be altered by styles and cfml template settings.
 */
component accessors="true" singleton {

	/******************************************** DI ************************************************************/

	property name="flash" inject="coldbox:flash";

	/******************************************** PROPERTIES ************************************************************/

	/**
	 * The flash message key to use in the flash RAM data struct
	 */
	property name="flashKey" type="string";

	/**
	 * The flash data key to use in the flash RAM data struct
	 */
	property name="flashDataKey" type="string";

	/**
	 * The default rendering template to use
	 */
	property name="template" type="string";

	/**
	 * Flag to override styles when rendering the template
	 */
	property
		name   ="styleOverride"
		type   ="boolean"
		default="false";

	/**
	 * The module root location so we can deliver UI assets
	 */
	property name="moduleRoot" type="string";

	// The static default separator for message arrays.
	variables.DEFAULT_SEPARATOR = "<br>";

	/**
	 * Constructor
	 *
	 * @config The messagebox module configuration structure
	 * @config.inject coldbox:modulesettings:cbmessagebox
	 */
	function init( required struct config ){
		// prepare properties
		variables.flashKey      = "coldbox_messagebox";
		variables.flashDataKey  = "coldbox_messagebox_data";
		variables.template      = arguments.config.template;
		variables.styleOverride = arguments.config.styleOverride;
		variables.moduleRoot    = arguments.config.moduleRoot;

		return this;
	}

	/**
	 * Facade to setmessage with dark type
	 *
	 * @message The message to flash, this can be a string or an array of messages
	 * @separator The separator to use when flatting the message if it's an array. The default is a `<br>` tag.
	 */
	MessageBox function dark( message = "", separator ){
		arguments.type = "dark";
		return setMessage( argumentCollection = arguments );
	}

	/**
	 * Facade to setmessage with light type
	 *
	 * @message The message to flash, this can be a string or an array of messages
	 * @separator The separator to use when flatting the message if it's an array. The default is a `<br>` tag.
	 */
	MessageBox function light( message = "", separator ){
		arguments.type = "light";
		return setMessage( argumentCollection = arguments );
	}

	/**
	 * Facade to setmessage with success type
	 *
	 * @message The message to flash, this can be a string or an array of messages
	 * @separator The separator to use when flatting the message if it's an array. The default is a `<br>` tag.
	 */
	MessageBox function success( message = "", separator ){
		arguments.type = "success";
		return setMessage( argumentCollection = arguments );
	}

	/**
	 * Facade to setmessage with error type
	 *
	 * @message The message to flash, this can be a string or an array of messages
	 * @separator The separator to use when flatting the message if it's an array. The default is a `<br>` tag.
	 */
	MessageBox function error( message = "", separator ){
		arguments.type = "error";
		return setMessage( argumentCollection = arguments );
	}

	/**
	 * Facade to setmessage with info type
	 *
	 * @message The message to flash, this can be a string or an array of messages
	 * @separator The separator to use when flatting the message if it's an array. The default is a `<br>` tag.
	 */
	MessageBox function info( message = "", separator ){
		arguments.type = "info";
		return setMessage( argumentCollection = arguments );
	}

	/**
	 * Facade to setmessage with warn type
	 *
	 * @message The message to flash, this can be a string or an array of messages
	 * @separator The separator to use when flatting the message if it's an array. The default is a `<br>` tag.
	 */
	MessageBox function warn( message = "" ){
		return warning( argumentCollection = arguments );
	}

	/**
	 * Facade to setmessage with warn type
	 *
	 * @message The message to flash, this can be a string or an array of messages
	 * @separator The separator to use when flatting the message if it's an array. The default is a `<br>` tag.
	 */
	MessageBox function warning( message = "", separator ){
		arguments.type = "warn";
		return setMessage( argumentCollection = arguments );
	}

	/**
	 * Create a new MessageBox with a specific message and type
	 *
	 * @type The message type, available types are: success, info, error, warn, light, dark
	 * @message The message to flash, this can be a string or an array of messages
	 * @separator The separator to use when flatting the message if it's an array. The default is a `<br>` tag.
	 *
	 * @throws InvalidMessageType - When an invalid type is sent
	 */
	MessageBox function setMessage(
		required type,
		message   = "",
		separator = variables.DEFAULT_SEPARATOR
	){
		var msg = {
			"type"    : arguments.type,
			"message" : (
				isSimpleValue( arguments.message ) ? arguments.message : arrayToList(
					arguments.message,
					arguments.separator
				)
			),
			"timestamp" : now()
		};

		// check message type
		if ( isValidMessageType( arguments.type ) ) {
			// Flash it and don't auto purge, we control the purge upon rendering or retrieval
			variables.flash.put(
				name        = variables.flashKey,
				value       = msg,
				inflateToRC = false,
				saveNow     = true,
				autoPurge   = false
			);
		} else {
			throw(
				message = "The message type is invalid: #arguments.type#",
				detail  = "Valid types are success, info, error, warn, dark, light",
				type    = "InvalidMessageType"
			);
		}

		return this;
	}

	/**
	 * Appends a message to the messagebox data. If there is no message, then it sets the default type to info.
	 *
	 * @message The message to append
	 * @defaultType The default type to use if not passed. Defaults to 'info'
	 * @separator The separator to use when flatenning the message array, it defaults to <br>
	 */
	MessageBox function append(
		required message,
		defaultType = "info",
		separator   = variables.DEFAULT_SEPARATOR
	){
		// Do we have a message?
		if ( isEmptyMessage() ) {
			// Set default message
			return setMessage(
				type      = arguments.defaultType,
				message   = arguments.message,
				separator = arguments.separator
			);
		}

		// Are we getting an array of messages to flatten?
		if ( isArray( arguments.message ) ) {
			arguments.message = arrayToList(
				arguments.message,
				arguments.separator
			);
		}

		// Get Current Message
		var currentMessage = getMessage();

		// Append it now
		return setMessage(
			type    = currentMessage.type,
			message = [
				currentMessage.message,
				arguments.message
			],
			separator = arguments.separator
		);
	}

	/**
	 * Prepend a message to the messagebox data. If there is no message, then it sets the default type to info.
	 *
	 * @message The message to prepend
	 * @defaultType The default type to use if not passed. Defaults to 'info'
	 * @separator The separator to use when flatenning the message array, it defaults to <br>
	 */
	MessageBox function prepend(
		required message,
		defaultType = "info",
		separator   = variables.DEFAULT_SEPARATOR
	){
		// Do we have a message?
		if ( isEmptyMessage() ) {
			// Set default message
			return setMessage(
				type      = arguments.defaultType,
				message   = arguments.message,
				separator = arguments.separator
			);
		}

		// Are we getting an array of messages to flatten?
		if ( isArray( arguments.message ) ) {
			arguments.message = arrayToList(
				arguments.message,
				arguments.separator
			);
		}

		// Get Current Message
		var currentMessage = getMessage();

		// Prepend it now
		return setMessage(
			type    = currentMessage.type,
			message = [
				arguments.message,
				currentMessage.message
			]
		);
	}

	/**
	 * Returns a structure of the messages if it exists, else a struct with the fields empty
	 *
	 * @return { type, message, timestamp }
	 */
	struct function getMessage(){
		return variables.flash.get(
			name        : variables.flashKey,
			defaultValue: {
				"type"      : "",
				"message"   : "",
				"timestamp" : now()
			}
		);
	}

	/**
	 * Clears the message structure by deleting it from the flash scope.
	 */
	MessageBox function clearMessage(){
		variables.flash.remove(
			name    = variables.flashKey,
			saveNow = true
		);
		return this;
	}

	/**
	 * Checks wether the messages are empty or not
	 */
	boolean function isEmptyMessage(){
		var msgStruct = getMessage();

		if ( msgStruct.type.length() eq 0 and msgStruct.message.length() eq 0 ) {
			return true;
		}

		return false;
	}

	/**
	 * WARNING: Override the entire flash metadata key with your own array of data.
	 *
	 * @theData The array of data to flash/override
	 */
	MessageBox function putData( required array theData ){
		// Flash it
		variables.flash.put(
			name        = variables.flashDataKey,
			value       = arguments.theData,
			inflateToRC = false,
			saveNow     = true,
			autoPurge   = false
		);
		return this;
	}

	/**
	 * Add metadata that can be used for saving arbitrary stuff alongside our flash messages.
	 * The name-value pair is added to the data collection (array)
	 *
	 * @key The key to store
	 * @value The value to store
	 */
	MessageBox function addData( required key, required value ){
		var data = variables.flash.get( variables.flashDataKey, [] );

		arrayAppend(
			data,
			{
				"key"   : arguments.key,
				"value" : arguments.value
			}
		);

		// Flash it
		variables.flash.put(
			name        = variables.flashDataKey,
			value       = data,
			inflateToRC = false,
			saveNow     = true,
			autoPurge   = false
		);

		return this;
	}

	/**
	 * Get the message data array stored in the message box
	 *
	 * @clearData clear the data from flash or not.
	 */
	array function getData( boolean clearData = true ){
		var data = variables.flash.get( variables.flashDataKey, [] );

		// clear?
		if ( arguments.clearData ) {
			variables.flash.remove(
				name    = variables.flashKey,
				saveNow = true
			);
			variables.flash.remove(
				name    = variables.flashDataKey,
				saveNow = true
			);
		}

		return data;
	}

	/**
	 * Get the message data as js
	 *
	 * @clearData clear the data from flash or not.
	 */
	string function getDataJSON( boolean clearData = true ){
		return serializeJSON( getData( arguments.clearData ) );
	}

	/**
	 * Renders the message box and clears the message structure by default
	 *
	 * @clearMessage Flag to clear the message structure or not after rendering. Default is true.
	 * @template An optional CFML template to use for rendering instead of core or setting
	 *
	 * @return The rendered messagebox template
	 */
	function renderIt(
		boolean clearMessage = true,
		template
	){
		var msgStruct    = getMessage();
		var thisTemplate = ( isNull( arguments.template ) ? variables.template : arguments.template );
		var results      = "";

		// Check for .cfm on the template, else appendit
		if ( !findNoCase( ".cfm", thisTemplate ) ) {
			thisTemplate &= ".cfm";
		}

		if ( msgStruct.type.length() neq 0 ) {
			savecontent variable="results" {
				include "#thisTemplate#";
			}
		}

		// clear?
		if ( arguments.clearMessage ) {
			variables.flash.remove(
				name    = variables.flashKey,
				saveNow = true
			);
			variables.flash.remove(
				name    = variables.flashDataKey,
				saveNow = true
			);
		}

		return results;
	}

	/**
	 * Returns true if the message box contains a message of specified type
	 *
	 * @type The message type, available types are: success, info, error, warn, dark, light
	 *
	 * @throws InvalidMessageType - When the type sent is invalid
	 */
	boolean function hasMessageType( required string type ){
		// validate message type
		if ( isValidMessageType( arguments.type ) ) {
			// don't bother checking for a message type if we don't have a message
			if ( isEmptyMessage() ) {
				return false;
			} else {
				var msgStruct = getMessage();
				return ( ( compareNoCase( msgStruct.type, arguments.type ) ) == 0 ) ? true : false;
			}
		} else {
			throw(
				message = "Invalid message type: #arguments.type#",
				detail  = "Valid types are success, info, error, warn, dark, light",
				type    = "InvalidMessageType"
			);
		}
	}


	/**
	 * Renders a messagebox immediately for you with the passed in arguments
	 *
	 * @type The message type, available types are: success, info, error, warn, dark, light
	 * @message The message to flash, this can be a string or an array of messages
	 * @separator The separator to use when flatting the message if it's an array. The default is a `<br>` tag.
	 * @template The CFML template to use to render the messagebox, if not passed then the one set as default will be used.
	 *
	 * @throws InvalidMessageType - When the type sent is invalid
	 */
	string function renderMessage(
		required type,
		message   = "",
		separator = variables.DEFAULT_SEPARATOR,
		template
	){
		// default the template
		var thisTemplate = ( isNull( arguments.template ) ? variables.template : arguments.template );
		// Check for .cfm on the template, else appendit
		if ( !findNoCase( ".cfm", thisTemplate ) ) {
			thisTemplate &= ".cfm";
		}
		// default the message struct just like we are flashing it
		var msgStruct = {
			"type"    : arguments.type,
			"message" : (
				isSimpleValue( arguments.message ) ? arguments.message : arrayToList(
					arguments.message,
					arguments.separator
				)
			),
			"timestamp" : now()
		};
		var results = "";

		// Validate message type
		if ( !isValidMessageType( arguments.type ) ) {
			throw(
				message = "Invalid message type: #arguments.type#",
				detail  = "Valid types are success, info, error or warn",
				type    = "InvalidMessageType"
			);
		}

		// Render it out.
		savecontent variable="results" {
			include "#thisTemplate#";
		}

		return results;
	}

	/******************************************** PRIVATE ************************************************************/

	/**
	 * Validate a type
	 *
	 * @type The message type
	 */
	private boolean function isValidMessageType( required string type ){
		return reFindNoCase(
			"(error|warn|info|success|dark|light)",
			trim( arguments.type )
		) ? true : false;
	}

}
