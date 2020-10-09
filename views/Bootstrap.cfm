<cfsetting enablecfoutputonly=true>
<cfif msgStruct.type eq "error">
	<cfset msgStruct.type = "danger">
</cfif>
<cfif msgStruct.type eq "warn">
	<cfset msgStruct.type = "warning">
</cfif>
<cfoutput>
<div class="alert alert-#msgStruct.type#">
	#msgStruct.message#
</div>
</cfoutput>
<cfsetting enablecfoutputonly="false">
