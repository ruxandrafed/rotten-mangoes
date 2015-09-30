class Admin::UsersController < ApplicationController

  before_filter :restrict_access

  def index
    @users = User.all.page(params[:page]).per(4)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "#{@user.full_name} was created successfully!"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_users_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    UserMailer.user_deletion_email(@user).deliver_now
    @user.destroy
    redirect_to admin_users_path, notice: "#{@user.full_name} was deleted successfully!"
  end

  protected

  def restrict_access
    if !admin?
      flash[:alert] = "You must be an admin to access that page."
      redirect_to :root
    end
  end

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end
