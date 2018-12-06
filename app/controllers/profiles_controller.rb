class ProfilesController < ApplicationController

  def show
    @user = current_user
  end
  
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def quiz_form
    @user = current_user
  end

  def quiz
    @user = current_user
    redirect_to profile_path
  end
  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :photo, :password)
  end
end
