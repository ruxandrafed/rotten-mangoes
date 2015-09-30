class Admin::SessionsController < ApplicationController

  def impersonate
    @user = User.find(params[:id])
    session[:admin_user_id] = current_user.id
    session[:user_id] = params[:id]
    redirect_to movies_path, notice: "You are now impersonating #{@user.full_name}."
  end

  def back_to_admin
    session[:user_id] = session[:admin_user_id]
    session[:admin_user_id] = nil
    redirect_to admin_users_path, notice: 'Back to admin role.'

  end

end
