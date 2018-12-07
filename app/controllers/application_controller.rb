class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :check_quizz_completion


  private

  def check_quizz_completion
  	if user_signed_in? && !current_user.quiz_completed
  		redirect_to quiz_form_profile_path
  	end
  end
end
