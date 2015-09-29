class Admin::UsersController < ApplicationController

  before_filter :restrict_access

  def index
    @users = User.all
  end

end
