if ($('#paginate-load-more-button').size() > 0) {
    $('#paginate-load-more-button .pagination').hide()

    $('#load-more-posts').show().click(function() {
        more_posts_url = $('#paginate-load-more-button .pagination .next_page a').attr('href');
        $this = $(this);
        $this.html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />').addClass('disabled');
        $.getScript(more_posts_url, function() {
            if ($this) {
                $this.text('Load more posts').removeClass('disabled');
            }
        });
    });
}
