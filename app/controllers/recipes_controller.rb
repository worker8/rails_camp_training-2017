class RecipesController < ApplicationController
  before_action :require_login, except: %i(show)

  def show
    # refactor this!
    @recipe = Recipe.find (params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    recipe = current_user.recipes.create(recipe_params)
    redirect_to recipe
  end

  def edit
    @recipe = find_recipe
  end

  def destroy
    recipe = find_recipe
    recipe.destroy
    redirect_to root_path
  end

  def update
    recipe = Recipe.find (params[:id])
    if recipe.update(recipe_params)
      redirect_to recipe, notice: t(".updated")
    else

    end
  end

  def find_recipe
    current_user.recipes.find(params[:id])
  end

  private
  def recipe_params
    params.require(:recipe).permit(:title, :description)
  end
end