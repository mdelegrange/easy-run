class Trainings::SessionsController < ApplicationController

  def show
  	@session = current_user.current_training.training_plan.training_sessions.find(params[:id])
  end

end
