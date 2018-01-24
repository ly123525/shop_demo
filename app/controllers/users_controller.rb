class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(set_params)
    @user.uuid = session[:user_uuid]
    if @user.save
      redirect_to new_session_path, :notice=>'注册成功！'
    else
      render :new
    end
  end

  private

  def set_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end