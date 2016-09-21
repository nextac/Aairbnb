class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "User successfully updated"
      redirect_to user_path(current_user.id)
    else
      flash[:notice] = "Update Failed"
      redirect_to user_path(current_user.id)
    end
  end

  def edit
     @user = current_user
  end

private
  # The following method is called strong params see google
  def user_params
    params.require(:user).permit(:email, :password, {avatars:[]})

  end

end
