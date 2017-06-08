class RecipeCommenting
  def initialize(user:, recipe:, comment_text:)
    @user = user
    @recipe = recipe
    @comment_text = comment_text
  end

  def run
    comment = user.comment_on(recipe, @comment_text)

    if comment.persisted?
      publish_activity(comment)
    end
  end

  private
  attr_reader :user, :recipe, :comment_text

  def comment_recipe
    user.likes(recipe)
  end

  def publish_activity(comment)
    UserActivityPublisher.new(user: user, target: comment, type: "comment").run
  end
end
