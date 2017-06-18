class Api::FollowsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :require_access_token

  def create
    if user_to_follow
      current_user.follow(user_to_follow)
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  def destroy
    if user_to_unfollow
      current_user.unfollow(user_to_unfollow)
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  private
  def user_to_follow
    @_user_to_follow ||= User.find_by(id: user_id)
  end

  alias user_to_unfollow user_to_follow

  def user_id
    params[:id]
  end
end