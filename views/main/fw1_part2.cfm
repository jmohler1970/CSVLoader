<h1>Services and Beans</h1>

<h4>With Services</h4>

<p>We can make controllers quite powerful. We can private functions to all kinds of things. But we really don't want to put a lot of businesss logic into it. Consider making a service. A service is a CFC with the following characteristics</p>

<ul>
	<li>It is located in <code>model/services</code></li>
	<li>It consists of objects with functions that are not session specific. Often times they do not even have member variables.</li>
	<li>If they did have a variable, it would be something that is setup once and stays the same for the duration of the application.</li>
	<li>The functions are shared across all users of the application.</li>
</ul>


<p>So is it a good idea to just list all the services in every controller? No. Just list the ones you need.</p>

<h4>With Beans (I mean Entities, I mean ORM)</h4>
<p>Disclaimer: FW/1 has a built in bean factory called Dependency Injection / 1 (DI/1). This document does not outline DI/1 usage. This document outlines standard ColdFusion Bean(Entity, ORM) management. An Entity is</p>



<ul>
	<li>An Entity is a <code>.cfc</code> that is backed by a database table</li>
	<li>properties define which columns will be built into the <code>.cfc</code> </li>
	<li>On application startup, it queries the DB for data types, so you don't have to</li>
	<li>It automatically creates get and set functions for each property</li>
	<li>It is compiled with the application starts up. They can later be created very fast.</li>
	<li>Because it is a <code>.cfc</code>, additional functions can be created.</li>
</ul>


<table class="table table-sm">
<thead>
	<tr>
		<th></th>
		<th>&lt;cfquery&gt;</th>
		<th>Entities</th>
	</tr>
</thead>
<tbody>
	<tr>
		<td>When querying, the result</td>
		<td>ColdFusion variable with columns and rows in a single unit.</td>
		<td>Array of Entities</td>
	</tr>
	<tr>
		<td>If I run a query and get no data</td>
		<td>ColdFusion variable with column names</td>
		<td>Array with nothing</td>
	</tr>
	<tr>
		<td>If I want to update a row</td>
		<td>Write UPDATE statement in TSQL</td>
		<td><code>EntityLoad()</code>, change the field, <code>EntitySave()</code></td>
	</tr>
	<tr>
		<td>How much can I tinker with result variable</td>
		<td>Some changes can be done via <code>QuerySetCell()</code></td>
		<td>Entities love to change</td>
	</tr>
	<tr>
		<td>I like ColdFusion query variables</td>
		<td>Great you have one</td>
		<td>Use <code>EntityToQuery()</code> and you have one</td>
	</tr>
</tbody>
</table>

<p>I don't even know what a bean is, what are you talking about? I was about to give a short answer. Then I ended up writing novel, and now I am back to writing the short version. Keep in mind this is missing way too many details.</p>

<p>Writing SQL is time consumming and error prone. Rather than dealing with INSERTS, SELECT, UPDATES, and DELETES, we are going to replace them with this. Below are the most important Entity functions</p>



<table class="table">
<thead>
	<tr>
		<th>Beans</th>
		<th>TSQL</th>
		<th>Returns</th>
		<th>Notes</th>
	</tr>
</thead>
<tbody>
	<tr>
		<td class="text-nowrap"><code>EntityDelete()</code></td>
		<td>DELETE</td>
		<td>Nothing</td>
		<td></td>
	</tr>
	<tr>
		<td class="text-nowrap"><code>EntityLoad()</code></td>
		<td>SELECT .., TOP (rows) ... WHERE ... ORDER BY</td>
		<td>Array of Entities by default, but can return single entity</td>
		<td>Probably the most flexible way to select.</td>
	</tr>
	<tr>
		<td class="text-nowrap"><code>EntityLoadByPK()</code></td>
		<td>SELECT or SELECT ... WHERE</td>
		<td>Single Entity.</td>
		<td>Entity already know what field or fields is/are the primary key.</td>
	</tr>
	<tr>
		<td class="text-nowrap"><code>EntityNew()</code></td>
		<td></td>
		<td>Single Entity</td>
		<td>Create and Entity and load it in with some of its data. This does not do the INSERT</td>
	</tr>
	<tr>
		<td class="text-nowrap"><code>EntitySave()</code></td>
		<td>INSERT or UPDATE</td>
		<td>Single Entity</td>
		<td>Commit Changes to DB</td>
	</tr>
	<tr>
		<td class="text-nowrap"><code>EntityToQuery()</code></td>
		<td></td>
		<td>ColdFusion Query variable or a crash</td>
		<td>This gets up out of the Array of Objects world and into the ColdFusion Query variable world. If you pass in an empty array, an error happens</td>
	</tr>
	<tr>
		<td class="text-nowrap"><code>ORMFlush()</code></td>
		<td></td>
		<td></td>
		<td>Any changes that may not have been committed to the DB, are committed immediately. This allows up to use normal SQL queries afterward.</td>
	</tr>
</tbody>
</table>


<h2>Services and Beans in FW/1 Revisited</h2>

<p>So both Services and Bean interact with databases. When should one be used over the other</p>

<h3>In favor of Services</h3>

<p>You should use Services when...</p>

<ul>
	<li>Non database interactions. This site does file uploads and processing via a Service</li>
	<li>For queries with complicated adhoc views or DB User Defined Functions</li>
	<li>Singleton: When you app only needs one of these kinds of things</li>
</ul>


<h3>In favor of Beans</h3>

<p>You should use Beans when...</p>

<ul>
	<li>Doing CRUD operations on tables</li>
	<li>Transient: When you app needs lots of these kinds of things.</li>
</ul>





