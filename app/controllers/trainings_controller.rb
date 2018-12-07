class TrainingsController < ApplicationController
  def show
    unless current_user.trainings.last.nil?
      @training_plan = current_user.trainings.last.training_plan
    end
  end
end
