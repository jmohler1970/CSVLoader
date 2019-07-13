
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title>CSV Loader</title>
	<meta name="author" content="James Mohler" />
	<meta name="description" content="Bootstrap tags for ColdFusion, a powerful tag libary that takes the best from Bootstrap for next-gen Front-end Enterprise Applications fast and easy supporting HTML5." />
	<meta name="KEYWORDS" content="ColdFusion, bootstrap, framework, java, enterprise, server, faces, jquery, usability, next-gen, web, html5, easy, modern, well-designed, website, state-of-the-art" />
	<meta name="robots" content="index, follow" />


	<meta name="viewport" content="width=device-width, initial-scale=1" />

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" crossorigin="anonymous">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.9.0/css/all.css" />
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" />
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap4.min.css" />

	<script src="https://code.jquery.com/jquery-3.3.1.min.js" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" crossorigin="anonymous"></script>
	<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
	<script src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>

	<style>
		ul.pagination li { padding : 0 !important}
	</style>

<head>

<body>

	<div class="container">

		<div class="jumbotron">
			<h1 class="display-4">CSV Loader!</h1>
			<p class="lead">This is a simple text extractor. It can do csv, tsv, pipes, and fixed. Give it a try.</p>
			<hr>
			<p>It uses cfc for file processing. Built on ColdFusion 2018.</p>
			<p class="lead">
				<a class="btn btn-primary btn-lg" href="https://github.com/jmohler1970/CSVLoader" role="button">Learn more</a>
			</p>
		</div>

		<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="/index.cfm">CSV Loader</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav">
				
				<li class="nav-item">
					<a class="nav-link" href="/index.cfm">Home</a>
				</li>
			
				<li class="nav-item">
					<a class="nav-link <cfif getItem() EQ 'load'>active</cfif>" href="/index.cfm/main/load">Import</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="/index.cfm/main/reports">Reports</a>
				</li>

			<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						Bootstrap Alerts
					</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="/index.cfm/main/bootstrap?alert=success">Success</a>
						<a class="dropdown-item" href="/index.cfm/main/bootstrap?alert=warning">Warning</a>
						<a class="dropdown-item" href="/index.cfm/main/bootstrap?alert=error">Error</a>
						<a class="dropdown-item" href="/index.cfm/main/bootstrap?alert=info">Info</a>
						<a class="dropdown-item" href="/index.cfm/main/bootstrap?alert=debug">Debug</a>
					</div>
				</li>

				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						DMV
					</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="/index.cfm/dmv/missing">Missing index</a>
						<a class="dropdown-item" href="/index.cfm/dmv/unused">Unused index</a>
						<a class="dropdown-item" href="/index.cfm/dmv/frag">Fragmented index</a>
						<a class="dropdown-item" href="/index.cfm/dmv/slow">Slow Queries</a>
						<a class="dropdown-item" href="/index.cfm/dmv/frag">Query Plan</a>
						<a class="dropdown-item" href="/index.cfm/dmv/compress">Table Compression</a>
					</div>
				</li>

			
				<li class="nav-item">
					<a class="nav-link" href="https://github.com/jmohler1970/CSVLoader"><i class="fab fa-github"></i></a>
				</li>
			</ul>

			</div>

			<form action="index.cfm" class="form-inline">
				<cfoutput>
				<input class="form-control mr-sm-2" name="search" type="search" placeholder="Search" value="#EncodeForHTMLAttribute(rc.search)#">
				</cfoutput>
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
		</nav>


		<cfif rc.keyexists("arMessage")><!--- Certain crashes can cause this to not exist --->
			<p></p>
			<cfoutput>#application.showMessage(rc.arMessage)#</cfoutput>
		</cfif>


		<cfoutput>#body.replacelist("~/", "/index.cfm/")#</cfoutput>

	</div>
</body>
</html>
