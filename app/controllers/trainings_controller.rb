class TrainingsController < ApplicationController
  def show
    unless current_user.trainings.last.nil?
      @training_plan = current_user.trainings.last.training_plan
    end
  end

  def create
    @training = Training.new(
      user_id: current_user.id,
      training_plan_id: 21,
      begin_date: Race.find(current_user.objectives.first.race_id).date - 126
      )
    if @training.save
      redirect_to objective_runs_path(current_user.current_objective.id)
    end
  end
end
