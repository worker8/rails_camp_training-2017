module RecipeHelper
  def like_button(recipe)
    if current_user.likes?(recipe)
      button_to t("unlike"), [:unlike, recipe]
    else
      button_to t("like"), [:like, recipe]
    end
  end

  def bookmark_button(recipe)
    if current_user.bookmarks?(recipe)
      button_to t("unbookmark"), [:unbookmark, recipe]
    else
      button_to t("bookmark"), [:bookmark, recipe]
    end
  end

end
