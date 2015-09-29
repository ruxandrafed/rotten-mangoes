class Admin::UsersController < ApplicationController

  before_filter :restrict_access

  def index
    @users = User.all
  end

  def restrict_access
    if !admin?
      flash[:alert] = "You must be an admin to access that page."
      redirect_to :root
    end
  end

end
