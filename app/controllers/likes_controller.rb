class LikesController < ApplicationController
  before_action :require_login

  def create
    RecipeLiking.new(user: current_user, recipe: recipe_to_like).run
    # current_user.likes(recipe_to_like)
    redirect_to recipe_to_like
  end

  def destroy
    current_user.unlikes(recipe_to_unlike)

    redirect_to recipe_to_unlike
  end

  private
  def recipe_to_like
    @_recipe_to_like ||= Recipe.find(recipe_id)
  end

  alias recipe_to_unlike recipe_to_like

  def recipe_id
    params[:id]
  end
end