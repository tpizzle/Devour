Devour.Models.RedditPost = Backbone.Model.extend({
    urlRoot: 'api/posts',
    
    comments: function() {
        if (!this._comments) {
            this._comments = new Devour.Collections.Comments([], { post: this });
        }
        return this._comments;
    },
    
    
});