class RecipeBookmarking
  def initialize(user:, recipe:)
    @user = user
    @recipe = recipe
  end

  def run
    bookmark = create_bookmark
    if bookmark.persisted?
      publish_activity
    end
  end

  private
  attr_reader :user, :recipe

  def create_bookmark
    user.bookmarks(recipe)
  end

  def publish_activity
    UserActivityPublisher.new(user: user, target: recipe, type: "bookmark").run
  end

end
