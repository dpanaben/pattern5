class UsersController < ApplicationController
  after_action :verify_authorized
  #Pundit example
  #raise "not authorized" unless UserPolicy.new(current_user, User).index?
  def index
    @users = policy_scope(User)
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted and posts moved to ADMIN."
  end

  private

  def secure_params
    params.require(:user).permit(:role)
    #params.require(:user).permit(*policy(@user || User).permitted_attributes)
  end

end
