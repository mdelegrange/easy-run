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
    @levels_options = [["shoes.svg", "DEBUTANT", "shoes-blue.svg"], ["timer.svg", "REGULIER", "timer-blue.svg"], ["winner.svg", "EXPERT", "winner-blue.svg"]]
    @targeted_distances = [["SEMI-MARATHON", 21097, "semi-marathon.svg"], ["MARATHON", 42195, "marathon.svg"]]

    @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }
  end

  def quiz
    if quizz_valid?
      current_user.update(quiz_params)
      current_user.quiz_completed = true
      current_user.save

      redirect_to races_path
    else
      build_quiz_errors
      @user = current_user
      @levels_options = [["shoes.svg", "DEBUTANT", "shoes-blue.svg"], ["timer.svg", "REGULIER", "timer-blue.svg"], ["winner.svg", "EXPERT", "winner-blue.svg"]]
      @targeted_distances = [["SEMI-MARATHON", 21097, "semi-marathon.svg"], ["MARATHON", 42195, "marathon.svg"]]

      @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }

      render :quiz_form
    end
  end

  private

  def quizz_valid?
    quiz_params[:level].present? && quiz_params[:targeted_distance].present? && quiz_params[:has_already_run].present?
  end

  def build_quiz_errors
    @quiz_errors = {}
    @quiz_errors[:level]             = 'Vous devez nous donner votre niveau' unless quiz_params[:level].present?
    @quiz_errors[:targeted_distance] = 'Vous devez nous donner votre objectif distance' unless quiz_params[:level].present?
    @quiz_errors[:has_already_run]   = 'Vous devez nous indiquer si vous avez déjà couru une course officielle' unless quiz_params[:level].present?
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :photo, :password)
  end

  def quiz_params
    params.require(:user).permit(:level, :targeted_distance, :has_already_run, :department)
  end
end

