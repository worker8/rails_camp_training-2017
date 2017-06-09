class RecipeUpdater
  def initialize(recipe:, recipe_params:)
    @recipe = recipe
    @recipe_params = recipe_params
  end

  def run
    recipe.update(recipe_params).tap do |is_success|
      if is_success
        build_index
      end
    end
    recipe
  end

  private
  attr_reader :recipe, :recipe_params

  def update_recipe
    recipe.update(recipe_params)
  end

  def build_index
    RecipeIndexer.new(recipe).run
  end
end
