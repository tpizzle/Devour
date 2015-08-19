Devour.Views.CommentItem = Backbone.CompositeView.extend({
  template: JST['reddit/comment/commentItem'],

  initialize: function(options) {
    this.listenTo(this.model, 'sync add', this.render);
  },

  render: function() {
    var content = this.template({ comment: this.model });
    this.$el.html(content);
    this.model.child_comments().forEach(function(child_comment) {
      console.log('sub-comment added');
      console.log(child_comment);
      var subCommentView = new Devour.Views.CommentItem({
        model: child_comment,
      });
      this.addSubview('.child-comments', subCommentView);
    });
    this.attachSubviews();
    return this;
  },
});
