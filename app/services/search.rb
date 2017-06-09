class Search
  def initialize(query:)
    @query = query
  end

  def run
    # Recipe.search(query)
    Recipe
      .joins(:search_index)
      .where("`search_indices`.`index` LIKE ?", query_string)
  end

  private
  attr_reader :query

  def query_string
    "%#{query}%"
  end
end