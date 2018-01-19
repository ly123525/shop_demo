class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(set_params)
    if @user
      redirect_to root_path, :notice=>'注册成功！'
    else
      render :new
    end
  end

  private

  def set_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end