

<h1>501 - Not Implemented</h1>


<cfoutput>
	<ul>
		<li>Failed action:		<cfif request.keyexists('failedAction')>#request.failedAction#<cfelse>unknown</cfif></li>
		<li>Application event:	<cfif request.keyexists('event')>#request.event#</cfif></li>
		<cfif request.keyexists('exception')>
			<li>Exception type:		#request.exception.type#</li>
			<li>Exception message:	#request.exception.message#</li>
			<li>Exception detail:	#request.exception.detail#</li>
		</cfif>
		<li>Failed Method: <cfif request.keyexists('failedMethod')>#request.failedMethod#<cfelse>unknown</cfif></li>
	</ul>
</cfoutput>

<div class="clearfix"></div>

<cfif NOT request.keyexists('exception')>
	<cfexit>
</cfif>

<cfdump var="#request.exception#">
