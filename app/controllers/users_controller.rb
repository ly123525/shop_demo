class UsersController < ApplicationController

  def new
    @is_using_email = true
    @user = User.new
  end

  def create
    @is_using_email = (params[:user] and !params[:user][:email].nil?)
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
    params.require(:user).permit(:email, :password, :password_confirmation, :cellphone, :token)
  end
end