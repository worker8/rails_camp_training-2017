class ApplicationController < ActionController::Base
  include Monban::ControllerHelpers
  protect_from_forgery with: :exception
  # before_action :require_login

  # used by api
  def require_access_token
    if !params[:access_token].present?
      render status: :unauthorized, json: {}
      return
    end

    credential = Credential.find_by(access_token: params[:access_token])
    if !credential.present?
      render status: :forbidden, json: {}
      return
    end

    @current_user = credential.user
  end

  private

  def current_user
    super || @current_user || Guest.new
  end
end
