class Api::CredentialsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    if invalid_params?
      render status: 400, json: {}
      return
    end

    user = authenticate_session(credential_params)
    if user
      credential = CredentialCreation.new(user: user).run
      render status: 200, json: credential.access_token
    else
      render status: 401, json: {}
    end
  end

  private
  def invalid_params?
    !valid_params?
  end

  def valid_params?
    credential_params[:email].present? && credential_params[:password].present?
  end

  def credential_params
    params.require(:user).permit(:email, :password)
  end

end