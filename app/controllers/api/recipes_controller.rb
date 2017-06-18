class Api::RecipesController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :require_access_token, except: :index

  PER_PAGE_NUMBER = 5.freeze

  def index
    recipes = Recipe.page(page_number).per(PER_PAGE_NUMBER)
    render json: recipes
  end

  def create
    recipe = RecipePublishing.new(user: current_user, recipe_params: recipe_params).run
    if recipe.persisted?
      render json: recipe, status: :ok
    else
      render json: recipe, status: :bad_request
    end
  end

  def destroy
    require_access_token
    recipe = find_recipe

    if recipe
      recipe.destroy
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  private

  def page_number
    params[:page] || 1
  end

  def find_recipe
    recipe = @current_user.recipes.find_by(id: params[:id])
    return recipe
  end

  def recipe_params
    params.require(:recipe)
      .permit(:title,
              :description,
              :image,
              ingredients_attributes: [:id, :name, :_destroy],
              steps_attributes: [:id, :name, :image, :_destroy])
  end

end