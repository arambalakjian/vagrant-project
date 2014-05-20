<div class="row">
    <div class="span12 flexslider-container">
        <div class="flexslider">
            <ul class="slides">
                <% loop Slides %>
                    <% if Image %>
                        <li>
                            <% if LinkedPage %><a href="$LinkedPage.Link"><% end_if %>
                                $Image
                            <% if LinkedPage %></a><% end_if %>
                            <div class="flex-caption <% if LinkText %>limit-width<% end_if %>">
                                <div class="caption-text">
                                    <h2>$Title</h2>
                                    <p>$Content</p>
                                </div>
                                <% if LinkText %>
                                    <a class="btn btn-primary btn-large" href="$LinkedPage.Link">$LinkText &raquo;</a></p>
                                <% end_if %>
                            </div>
                        </li>
                    <% end_if %>
                <% end_loop %>
            </ul>
        </div>
    </div>
</div>