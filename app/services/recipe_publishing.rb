class RecipePublishing
  def initialize(user:, recipe_params:)
    @user = user
    @recipe_params = recipe_params
  end

  def run
    build_recipe.tap do |recipe|
      if recipe.save
        publish_activity(recipe)
      end
    end
  end

  private
  attr_reader :user, :recipe_params

  def build_recipe
    user.recipes.build(recipe_params)
  end

  def publish_activity(recipe)
    UserActivityPublisher.new(user: user, target: recipe, type: "publish_recipe").run
  end
end
