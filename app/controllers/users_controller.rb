class UsersController < ApplicationController
  before_action :is_admin

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted and posts moved to ADMIN."
  end

  private

  def is_admin
    unless current_user.admin?
      redirect_to root_url, notice: "You are not authorized to that area."
    end
  end

  def secure_params
    params.require(:user).permit(:role)
    #params.require(:user).permit(*policy(@user || User).permitted_attributes)
  end

end
