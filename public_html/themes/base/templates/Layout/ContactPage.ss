<div class="container">
	<div class="row">
		<div class="content-wrapper typography">	
			<article>
				<h1>$Title</h1>
				<div class="content">$Content</div>
				<% if not Success %>
					$ContactForm
				<% end_if %>
				<div id="contact-response" class="alert <% if Success %>show<% end_if %>">Your message has been sent.</div>
			</article>
		</div>
	</div>
</div>