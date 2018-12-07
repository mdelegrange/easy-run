class ProfilesController < ApplicationController
  skip_before_action :check_quizz_completion, only: [:quiz_form, :quiz]
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
      ["Je cours de temps en temps", "intermediate"],
      ["Je cours régulièrement", "advanced"]
   ]
    @targeted_distances = [["Finir un marathon", 42195]]
    @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }
  end

  def quiz
    if current_user.update(quiz_params)
      redirect_to races_path
    else
      render :new
  end
end
  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :photo, :password)
  end

  def quiz_params
    params.require(:user).permit(:level, :targeted_distance, :has_already_run, :department)
  end
end
