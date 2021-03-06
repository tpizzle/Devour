Devour.Views.forumShow = Backbone.CompositeView.extend({

  template: JST['forum/forumShow'],

  initialize: function(options) {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function() {
    this.$el.html(this.template({ model: this.model }));
    var subforumView = this;
    this.model.posts().forEach(function(post) {
      var postView = new Devour.Views.PostItem({ model: post });
      subforumView.addSubview('tbody.posts-table', postView);
    });
    this.attachSubviews();
    return this;
  },

});
