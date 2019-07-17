<h1>Framework 1</h1>

<h3>Introduction</h3>

<p>When building non trivial websites, the following needs arise</p>

<ul>
	<li>They are made of multiple pages</li>
	<li>They have standard layouts</li>
	<li>There are different kinds of files. Some are front end oriented, others are back end oriented</li>
	<li>Objects happen</li>
	<li>Ad hoc organization eventually becomes a problem</li>
</ul>


<h3>Ideas behind FW/1</h3>

<p>The short description of FW/1 is that it is an Model-Vue-Controller (MVC) framework for ColdFusion. While that is true, I have a different way of describing it. It is a framework that encourages you to drop certain files into certain locations. The more you follow its desired pattern, the more stuff happens automatically. Let's start with a page request.</p>

<pre>http://localhost:8079/index.cfm/main/home</pre>

<p>Let's focus on the <code>main/home</code> part. At a minium, this is going to get translated into <code>views/main/home.cfm</code> . We are also going to get some others.</p>

<h4>With layouts</h4>

<code>main/home</code> could become

<ul>
	<li><code>views/main/home.cfm</code></li>
	<li><code>layouts/default.cfm</code></li>
</ul>

<p>Layouts are were standard headers and footers happen. Perhaps the site menu is implemented there. <code>layouts/default.cfm</code> is processed after the view, but the content it generates can be before the view. It works something like this</p>

<div class="alert alert-dark" role="alert">
<pre>Heading
&lt;cfoutput&gt;#body#&lt;/cfoutput&gt;
Footer</pre>
</div>

<h4>With controllers</h4>

<p>All of this has been focusing on presentation. What if I want to setup some variables before presenting them?</p>


<ul>
	<li><code>controllers/main.cfc::home(rc)</code></li>
	<li><code>views/main/home.cfm</code></li>
	<li><code>layouts/default.cfm</code></li>
</ul>

We are going to take the <code>main/home</code>, and convert it.

<ul>
	<li>The object is based on the first part of the URL pattern. This is called the section.</li>
	<li>The function name is based on the first part of the URL pattern. This is called the item.</li>
	<li><code>rc</code> is struct containing all the <code>url</code> variables, all the <code>form</code> variables, and anything else you want to add onto it. The function itself returns void.</li>
</ul>

<h4>Before I do anything section specific...</h4>

<p>Before I do anything section specific, I want to run some code that will apply to all items in a section. </p>

<ul>
	<li><code>controllers/main.cfc::before(rc)</code></li>
	<li><code>controllers/main.cfc::home(rc)</code></li>
	<li><code>views/main/home.cfm</code></li>
	<li><code>layouts/default.cfm</code></li>
</ul>

<p>Just add in a <code>before()</code> function. Is it a requirement to have a before? No. Is it a requirement to have an item specfic function? No. Is it a requirement that main.cfc exist? No. Just add in what you need when you need it.</p>

<a href="~/main/fw1_part2" class="btn btn-secondary">Part 2: Services and Beans</a>






