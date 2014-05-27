<footer class="footer" role="contentinfo">
	<div class="container">
    	<div class="upper">
    		
    		<div class="content-block">
    			
    			<h2>Links</h2>
    				
    			<ul>
    			<% loop Menu(1) %>
    				<li><a href="$Link">$MenuTitle</a></li>
    			<% end_loop %>
    			</ul>	
    		</div>	
    		
    		<div class="content-block">
    			
    			<h2>About</h2>
    				
    			<p>Lorem a pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia.</p>
    
    			<a class="more" href="#">...read more</a>
    			
    		</div>	
    		
    		<div class="content-block">
    			
    			<h2>About</h2>
    				
    			<p>Lorem a pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui.</p>
    
    			<a class="more" href="#">...read more</a>
    			
    		</div>	
    		
    		<div class="content-block">
    			
    			<h2>Links</h2>
    				
    			<ul>
                    <li><a href="#link1" id="link1">Link1</a></li>
                    <li><a href="#link2">Link2</a></li>
                    <li><a href="#link3">Link3</a></li>
                    <li><a href="#link4">Link4</a></li>
    				<li><a href="#link5">Link5</a></li>
    			</ul>	
    		</div>
        
        </div>	
	</div><!-- /Upper Container-->   

	<div class="lower">
    	<div class="container">
    		<div class="lower-content">
    		
        		<div class="copyright">	
        			<p>&copy; $SiteConfig.Title $Now.Year</p>
        		</div>
        		<div class="credit">
                    <p>
                    	Crafted by <a href="http://www.carboncrayon.com" title="Site Crafted by Carbon Crayon">Carbon Crayon</a>
                    </p>
        		</div>
    			
    		</div>
		</div><!-- /Lower Container-->
	</div>
</footer>