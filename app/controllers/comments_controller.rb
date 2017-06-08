class CommentsController < ApplicationController
  before_action :require_login

  def create
    # comment = current_user.comments.build(comments_params)
    current_user.comment_on(recipe, params[:comment][:text])
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