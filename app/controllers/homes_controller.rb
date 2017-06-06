class HomesController < ApplicationController
  def show
    @recipe = Recipe.all
  end
end