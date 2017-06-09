class RecipePublishing
  def initialize(user:, recipe_params:)
    @user = user
    @recipe_params = recipe_params
  end

  def run
    recipe = publish_recipe
    if recipe.save
      publish_activity(recipe)
    end
    recipe
  end

  private
  attr_reader :user, :recipe_params

  def publish_recipe
    user.recipes.build(recipe_params)
  end

  def publish_activity(recipe)
    UserActivityPublisher.new(user: user, target: recipe, type: "publish_recipe").run
  end
end
