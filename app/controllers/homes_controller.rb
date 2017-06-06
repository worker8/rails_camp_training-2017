class HomesController < ApplicationController
  def show
    @recipes = Recipe.latest.page(params[:page]).per 1
  end
end