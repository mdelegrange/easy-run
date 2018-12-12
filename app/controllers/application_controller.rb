class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :check_quizz_completion
  skip_before_action :check_quizz_completion, only: [:home]

  private

  def check_quizz_completion
  	if user_signed_in? && current_user.quiz_completed == false
  		redirect_to quiz_form_profile_path
  	end
  end

  def default_url_options
    { host: ENV["HOST"] || "localhost:3000" }
  end
end
