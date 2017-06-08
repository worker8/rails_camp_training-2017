class BookmarksController < ApplicationController
  before_action :require_login

  def create
    RecipeBookmarking.new(user: current_user, recipe: recipe_to_bookmark).run
    # current_user.bookmarks(recipe_to_bookmark)
    redirect_to recipe_to_bookmark
  end

  def destroy
    current_user.unbookmarks(recipe_to_bookmark)
    redirect_to recipe_to_unbookmark
  end

  private
  def recipe_to_bookmark
    @_recipe_to_bookmark ||= Recipe.find(recipe_id)
  end

  alias recipe_to_unbookmark recipe_to_bookmark

  def recipe_id
    params[:id]
  end
end