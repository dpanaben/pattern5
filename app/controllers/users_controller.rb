class UsersController < ApplicationController
  def index
    if current_user && current_user.admin?
      @users = User.all
    else
      redirect_to root_url, notice: "You are not authorized"
    end
  end

  def show
    if current_user && current_user.admin?
      @user = User.find(params[:id])
    else
      redirect_to root_url, notice: "You are not authorized"
    end
  end

  def update
    if current_user && current_user.admin?
      @user = User.find(params[:id])
      if @user.update_attributes(secure_params)
        redirect_to users_path, :notice => "User updated."
      else
        redirect_to users_path, :alert => "Unable to update user."
      end
    else
      redirect_to root_url, notice: "You are not authorized"
    end
  end


  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted and posts moved to ADMIN."
  end

  private

  def secure_params
    params.require(:user).permit(:role)
    #params.require(:user).permit(*policy(@user || User).permitted_attributes)
  end

end
