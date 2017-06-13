class Api::RecipesController < ApplicationController
  protect_from_forgery with: :null_session

  PER_PAGE_NUMBER = 5.freeze

  def index
    recipes = Recipe.page(page_number).per(PER_PAGE_NUMBER)
    render json: recipes
  end

  private

  def page_number
    params[:page] || 1
  end
end