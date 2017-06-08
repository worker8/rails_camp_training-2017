class RecipeLiking
  def initialize(user:, recipe:)
    @user = user
    @recipe = recipe
  end

  def run
    like = like_recipe
    if like.persisted?
      publish_activity
    end
  end

  private
  attr_reader :user, :recipe

  def like_recipe
    user.likes(recipe)
  end

  def publish_activity
    UserActivityPublisher.new(user: user, target: recipe, type: "like").run
  end
end
