class Guest

  def owns?(_)
    false
  end

  # def recipes
  #   Recipe.none #<-- provided by rails, a null, can combo into Recipe.none.something.relationship
  # end

  def likes?(_)
    false
  end

  def follows?(_)
    false
  end

  def bookmarks?(_)
    false
  end
end
