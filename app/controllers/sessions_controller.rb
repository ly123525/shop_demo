class SessionsController < ApplicationController
  def new
  end

  def create
    if user = login(params[:email], params[:password])
       redirect_to root_path, :notice=>'登陆成功！'
    else
      redirect_to new_session_path, :alert=>'邮箱或密码不正确'
    end
  end

  def destroy
    logout
    redirect_to root_path, :notice=>'安全退出'
  end
end
