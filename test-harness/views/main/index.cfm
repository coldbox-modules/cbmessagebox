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