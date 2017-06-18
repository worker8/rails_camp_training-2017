class Api::UsersController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    user = sign_up(user_params)

    if user.valid?
      credential = CredentialCreation.new(user: user).run
      render status: 200, json: credential.access_token
    else
      render status: 400, json: {}
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username, :avatar)
  end

end