class Dashboard::ProfileController < Dashboard::BaseController


  def password

  end

  def update_password
    if current_user.valid_password?(params[:old_password])
      current_user.password_confirmation= params[:password_confirmation]
      if current_user.change_password!(params[:password])
        redirect_to dashbord_password_path
      else
        render :password

      end
    else
      current_user.errors.add :old_password, "原密码不正确"
      render :password
    end
  end
end