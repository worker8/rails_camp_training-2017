class CommentsController < ApplicationController
  before_action :require_login

  def create
    # current_user.comments.build(comments_params)
    RecipeCommenting.new(user: current_user, recipe: recipe, comment_text: params[:comment][:text]).run
    redirect_to recipe

    # if @recipe.save
    #   redirect_to @recipe
    # else
    #   render :edit
    # end
  end

  def destroy
    comment.destroy
    redirect_to recipe
  end

  private
  def recipe
    Recipe.find params[:recipe_id]
  end

  def comment
    Comment.find params[:id]
  end
end