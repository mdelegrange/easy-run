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
    @levels_options = [
      ["Je n'ai jamais couru", "beginner"],
      ["Je cours de temps en temps (environ 1 fois par semaine)", "intermediate"],
      ["Je cours régulièrement (plus de 2 fois par semaine", "advanced"]
   ]
  end

  def quiz
    current_user.update(quiz_params)
    redirect_to profile_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :photo, :password)
  end

  def quiz_params
    params.require(:user).permit(:level)
  end
end
