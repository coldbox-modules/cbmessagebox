<cfoutput>
<h1>MessageBox</h1>
#getInstance( "MessageBox@cbmessagebox" ).renderMessage( "success", "I am success! I <a href='##'>am a link</a>" )#
#getInstance( "MessageBox@cbmessagebox" ).renderMessage( "info", "I am info! I <a href='##'>am a link</a>" )#
#getInstance( "MessageBox@cbmessagebox" ).renderMessage( "warn", "I am warn! I <a href='##'>am a link</a>" )#
#getInstance( "MessageBox@cbmessagebox" ).renderMessage( "error", "I am error! I <a href='##'>am a link</a>" )#
#getInstance( "MessageBox@cbmessagebox" ).renderMessage( "dark", "I am a dark alert! I <a href='##'>am a link</a>" )#
#getInstance( "MessageBox@cbmessagebox" ).renderMessage( "light", "I am a light alert! I <a href='##'>am a link</a>" )#
</cfoutput>