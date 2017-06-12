class My::UsersController < My::BaseController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to @user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username, :avatar)
  end
end
