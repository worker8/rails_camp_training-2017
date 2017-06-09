class RecipeSearchQuery
  def initialize(query:)
    @query = query
  end

  def to_relation
    # Recipe.join
    Recipe.join
  end

  def matching_title
    recipes.where("title LIKE ?", "%#{@query}%")
  end

  def recipes
    Recipe.joins(:ingredients)
  end

  private
  attr_reader :query

end
