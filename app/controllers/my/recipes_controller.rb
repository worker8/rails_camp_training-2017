class My::RecipesController < My::BaseController
  # TODO: extract to base controller

  def new
    @recipe = Recipe.new #(ingredients: [Ingredient.new])
  end

  def create
    @recipe = RecipePublishing.new(user: current_user, recipe_params: recipe_params).run #current_user.recipes.build(recipe_params)
    if @recipe.persisted?
      redirect_to @recipe
    else
      render :edit
    end
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
    recipe = find_recipe

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
    params.require(:recipe)
      .permit(:title,
              :description,
              ingredients_attributes: [:id, :name, :_destroy],
              steps_attributes: [:id, :name, :_destroy])
  end
end