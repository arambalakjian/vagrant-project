<aside class="sidebar">
	<% if Menu(2) %>
		<nav class="secondary-nav">
			<h3>
				<% with Level(1) %>
					$Title
				<% end_with %>
			</h3>
			<ul>
				<% loop Menu(2) %>
					<li><a class="$LinkingMode" href="$Link" title="Go to the $Title.XML page">$MenuTitle.XML</a></li>
				<% end_loop %>
			</ul>
		</nav>
	<% end_if %>  	
</aside>
