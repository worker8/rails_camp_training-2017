class Api::CredentialsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    if invalid_params?
      render status: :bad_request, json: {}
      return
    end

    user = authenticate_session(credential_params)
    if user
      credential = CredentialCreation.new(user: user).run
      render status: :ok, json: credential.access_token
    else
      render status: :unauthorized, json: {}
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