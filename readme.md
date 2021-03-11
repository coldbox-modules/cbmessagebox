[![Build Status](https://travis-ci.org/coldbox-modules/cbmessagebox.svg?branch=development)](https://travis-ci.org/coldbox-modules/cbmessagebox)

# WELCOME TO THE MESSAGEBOX MODULE

The MessageBox module is a very small but super useful UI module that allows you to create informative HTML message boxes by leveraging ColdBox's Flash RAM to save messages across relocations.  You can even save an array of metadata alongside the message and use it for custom rendering or any type of purposes.

## Message Types

The supported message types are:

* `info`
* `warn`
* `error`
* `success`
* `dark`
* `light`

Please note that you can skin these types as you see fit by either overriding the css tyles or creating your own messagebox cfm template.

<img src="https://raw.githubusercontent.com/coldbox-modules/cbmessagebox/development/test-harness/messageboxes.png">

## LICENSE

Apache License, Version 2.0.

## IMPORTANT LINKS

* https://github.com/coldbox-modules/cbmessagebox
* https://forgebox.io/view/cbmessagebox
* [Changelog](changelog.md)

## SYSTEM REQUIREMENTS

* Lucee 5+
* ColdFusion 2016+

# INSTRUCTIONS

Just drop into your **modules** folder or use CommandBox to install

`box install cbmessagebox`

## WireBox Mappings

The module registers the MessageBox model: `messagebox@cbmessagebox` that you can use to emit messages. Check out the API Docs for all the possible functions.

## Helpers

The module also registers a helper mixin: `cbMessagebox()` that you can use in your handlers, interceptors, layouts and views to emit or render messages.

## Settings

You can use the MessageBox as is with the current skin or use the functions or settings to overide styles and skinning template.  You must place the settings in your `ColdBox.cfc` file under the `moduleSettings.cbMessagebox` struct:

```js
moduleSettings = {

	cbMessagebox = {
		/// The default HTMl template for emitting the messages, this can include or not the .cfm and be 
		// an include path.
		template 		= "/includes/templates/messagebox",
		// Override the internal styles, true to override
		styleOverride 	= false
	}
};
```

## Usage

You can find all the methods in our API Docs: <a href="https://apidocs.ortussolutions.com/#/coldbox-modules/cbmessagebox/">https://apidocs.ortussolutions.com/#/coldbox-modules/cbmessagebox/</a>

All methods that accept a `message` argument can accept either a string or an array of messages to store and render.  You can also pass in an optional `separator` argument which will be used to join the messages with.  The default separator is a `<br>` tag.

Methods for setting messages:

* `info( message, separator='<br>' )` : To render info message directly
* `warning( message, separator='<br>' )` : To render a warning message
* `error( message, separator='<br>' )` : To render an error message
* `success( message, separator='<br>' )` : To render a success message
* `dark( message, separator='<br>' )` : To render a dark background message
* `light( message, separator='<br>' )` : To render a light background message
* `setMessage( type, message, separator='<br>' )` : Set a message according to passed type

Methods for manipulating messages:

* `append( message, defaultType="info", separator='<br>' )` : To append messages
* `prepend( messageArray, defaultType="info", separator='<br>' )` : To prepend messages
* `getMessage()` : Get a structure of the message data: `{ type, message, timestamp }`
* `clearMessage()` : To clear the current message
* `isEmptyMessage()` : Verify if you have any messages

Metadata addition to messages:

* `addData( key, value )` : Add name-value pairs of metadata to the flash structure as metadata for messages
* `putData( array theData )` : Incorporate an array of metadata to the flash structure
* `getData( clearData=true )` : Get the metadata structure
* `getDataJSON( clearData=true )` : To get the metadata as JSON

Rendering methods:

* `renderit( clearMessage=true, template )` : To render the messagebox in the default template or passed template
* `renderMessage( type, message, separator='<br>', template )` : To render an a-la-carte messagebox with the default template or passed template

### Examples

```html
<cfoutput>
<h1>MessageBox Renderit</h1>
#cbMessageBox().renderIt()#

<hr>

<h1>MessageBox Renderit With Template</h1>
<cfset cbMessageBox().info( "Rendering a custom template" )>
#cbMessageBox().renderIt( template : "/includes/messagebox" )#

<hr>

<h1>MessageBox Direct Render</h1>
#cbMessageBox().renderMessage( "success", "I am success! I <a href='##'>am a link</a>" )#
#cbMessageBox().renderMessage( "info", "I am info! I <a href='##'>am a link</a>" )#
#cbMessageBox().renderMessage( "warn", "I am warn! I <a href='##'>am a link</a>" )#
#cbMessageBox().renderMessage( "error", "I am error! I <a href='##'>am a link</a>" )#
#cbMessageBox().renderMessage( "dark", "I am a dark alert! I <a href='##'>am a link</a>" )#
#cbMessageBox().renderMessage( "light", "I am a light alert! I <a href='##'>am a link</a>" )#

<hr>

<h1>Message Arrays</h1>
#cbMessageBox().renderMessage( "success", [
	"I am success! I <a href='##'>am a link</a>",
	"I love being successful!"
]  )#
#cbMessageBox().renderMessage( "info", [
	"I am info! I <a href='##'>am a link</a>",
	"I love being info!"
]  )#
#cbMessageBox().renderMessage( "warn", [
	"I am warn! I <a href='##'>am a link</a>",
	"I love being warnful!"
]  )#
#cbMessageBox().renderMessage( "error", [
	"I am error! I <a href='##'>am a link</a>",
	"I love being errorful!"
]  )#
#cbMessageBox().renderMessage( "dark", [
	"I am dark! I <a href='##'>am a link</a>",
	"I love being darkful!"
]  )#
#cbMessageBox().renderMessage( "light", [
	"I am light! I <a href='##'>am a link</a>",
	"I love being lightful!"
]  )#
</cfoutput>
```

> **Important**: Please note that the MessageBox module leverages the FlashRAM and all messages are cleared for you automatically after rendering.  You can delay that if you use the `clearMessage=false` argument.


## MessageBox Custom Templates

The MessageBox module will render out the MessageBox HTML according to our standards.  However, we all know the developers are picky beings and very individualistic.  Therefore, we allow the usage of your own templates for rendering out the MessageBox. You can do this by using the custom settings in your `ColdBox.cfc` configuration file or pass in the template via the `template` argument.

```js
messagebox = {
    // The default HTMl template for emitting the messages
	template 		= "/cbmessagebox/views/MessageBox",
    // Override the internal styles, true to override
	styleOverride 	= false
};
```

The template can then be written:

```html
<cfscript>
	switch( msgStruct.type ){
		case "info" : {
			local.cssType = " alert-info";
			local.iconType = "icon-info-sign";
			break;
		}	
		case "error" : {
			local.cssType = " alert-error";
			local.iconType = "icon-minus-sign";
			break;
		}	
		default : {
			local.cssType = "";
			local.iconType = "icon-warning-sign";
		}
	}
</cfscript>
<cfoutput>
<div class="alert#local.cssType#" style="min-height: 38px">
	<button type="button" class="close" data-dismiss="alert">×</button>
	<i class="#local.iconType# icon-large icon-2x pull-left"></i> #msgStruct.message#
</div>
</cfoutput>
```

You can also ignore the global setting and use the `template` argument via the `renderIt()` and `renderMessage()` methods:

```html
#cbMessageBox().renderit(template=path)#
#cbMessageBox().renderMessage(type="info", message="Hello", template=path)#
```

## Utility Methods

The plugin also sports some convenience methods:

* `getMessage()` : Retrieve the raw message structure
* `clearMessage()` : Clear the Flash RAM
* `isEmptyMessage()` : Verify if we have messages to show

## Custom Metadata

You can also store custom metadata alongside your custom messages.  This is great for storing any type of information you might need again back when rendering the messages.  For this we have the following methods:

* `putData(array data)` : Add an array of data that can be used for arbitrary stuff
* `addData(key, value)` : Store key-value pairs of metadata alongside the message
* `getData([clearData=true])` : Get your array of data back
* `getDataJSON([clearData=true])` : Get your array of data back as JSON

## Custom CSS

If you want to style your own MessageBox you will need to use the `styleOverride` messagebox settings in your `ColdBox.cfc`.  Then make sure the CSS for the MessageBox exists in the request, usually in your main CSS file or layout:

```js
messagebox = {
    // Override the internal styles, true to override
	styleOverride 	= true
};
```

> **Important** : Please note that the `MessageBox` model has getters/setters for all of its properties so you can manipulate its instance data.

********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************

### HONOR GOES TO GOD ABOVE ALL

Because of His grace, this project exists. If you don't like this, then don't read it, its not for you.

>"Therefore being justified by faith, we have peace with God through our Lord Jesus Christ:
By whom also we have access by faith into this grace wherein we stand, and rejoice in hope of the glory of God.
And not only so, but we glory in tribulations also: knowing that tribulation worketh patience;
And patience, experience; and experience, hope:
And hope maketh not ashamed; because the love of God is shed abroad in our hearts by the 
Holy Ghost which is given unto us. ." Romans 5:5

### THE DAILY BREAD

 > "I am the way, and the truth, and the life; no one comes to the Father, but by me (JESUS)" Jn 14:1-12
