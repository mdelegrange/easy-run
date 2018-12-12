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
    @levels_options = [["shoes", "DEBUTANT", "shoes-blue"], ["timer", "REGULIER", "timer-blue"], ["winner", "EXPERT", "winner-blue"]]
    @targeted_distances = [["SEMI-MARATHON", 21000, "semi-marathon"], ["MARATHON", 42195, "marathon"]]

    @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }
  end

  def quiz
    if current_user.update(quiz_params)
      current_user.quiz_completed = true
      current_user.save

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

