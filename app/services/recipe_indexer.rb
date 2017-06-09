class RecipeIndexer
  def initialize(recipe)
    @recipe = recipe
  end

  def run
    search_index = get_search_index
    search_index.index = recipe_index
    search_index.save
  end

  private
  attr_reader :recipe

  def get_search_index
    SearchIndex.find_or_initialize_by(recipe: recipe)
  end

  def recipe_index
    (recipe_values + ingredients_values).join(" ")
  end

  def recipe_values
    [recipe.title]
  end

  def ingredients_values
    recipe.ingredients.map(&:name)
  end
end