<div id="Content" class="searchResults typography">
    
    <div class="row">

        <div class="span12">
 
            <h1>$Title</h1>
             
            <% if Query %>
                <p class="searchQuery alert alert-info"><strong>You searched for &quot;{$Query}&quot; which returned $Results.Count results.</strong></p>
            <% end_if %>      
                 
            <% if Results %>
            <ul id="SearchResults">
                <% loop Results %>
                <li>
                    <a class="searchResultHeader" href="$Link">
                        <% if MenuTitle %>
                        $MenuTitle
                        <% else %>
                        $Title
                        <% end_if %>
                    </a>
                    <p>$Content.LimitWordCount(30)</p>
                    <p><a class="readMoreLink" href="$Link" title="Read more about &quot;{$Title}&quot;">Read more about &quot;{$Title}&quot;...</a></p>
                </li>
                <% end_loop %>
            </ul>
            <% else %>
            <p class="alert">Sorry, your search query did not return any results.</p>
            <% end_if %>
                     
            <% if Results.MoreThanOnePage %>
            <div id="PageNumbers">
                <div class="pagination">
                    <ul>
                        <% if Results.NotFirstPage %>
                            <li><a class="prev" href="$Results.PrevLink" title="View the previous page">&larr;</a></li>
                        <% end_if %>
                    
                        <% loop Results.Pages %>
                            <li class="<% if CurrentBool %>active<% end_if %>">
                                <a href="$Link" title="View page number $PageNum">$PageNum</a>
                            </li>
                        <% end_loop %>
                        
                        <% if Results.NotLastPage %>
                            <li><a class="next" href="$Results.NextLink" title="View the next page">&rarr;</a></li>
                        <% end_if %>
                    </ul>
                </div>

            </div>
            <% end_if %>
            
        </div>    
   </div>
</div>