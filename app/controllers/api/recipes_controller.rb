class Api::RecipesController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :require_access_token

  PER_PAGE_NUMBER = 5.freeze

  def index
    recipes = Recipe.page(page_number).per(PER_PAGE_NUMBER)
    render json: recipes
  end

  def create
    # recipe = current_user.recipes.create(recipe_params)
    recipe = RecipePublishing.new(user: current_user, recipe_params: recipe_params).run
    if recipe.persisted?
      render json: recipe, status: 200
    else
      render json: recipe, status: 400
    end
  end

  def destroy
    require_access_token
    recipe = find_recipe

    if recipe
      recipe.destroy
      render json: {}, status: 200
    else
      render json: {}, status: 400
    end
  end

  private

  def page_number
    params[:page] || 1
  end

  def require_access_token
    if !params[:access_token].present?
      render status: 401, json: {}
      return
    end

    credential = Credential.find_by(access_token: params[:access_token])
    if !credential.present?
      render status: 403, json: {}
      return
    end

    @current_user = credential.user
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