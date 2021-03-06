class TrainingsController < ApplicationController
  def show
    unless current_user.trainings.last.nil?
      @training_plan = current_user.trainings.last.training_plan
    end
  end

  def create
    @training = Training.new(
      user_id: current_user.id,
      training_plan_id: TrainingPlan.first.id,
      begin_date: next_monday,
      status: 'current'
      )
    if @training.save

    current_user.trainings.last.training_plan.update(end_date: current_user.objectives.last.race.date)
    TrainingSession.where(training_plan:(current_user.trainings.last.training_plan.id)).order(:position).each_slice(3).to_a.each_with_index{|training_week, index| training_week.each{|training| training.update(week: index + 1)}}
    redirect_to objective_runs_path(current_user.objectives.last)
    end
  end

  private

  def next_monday
    date  = Date.parse('monday')
    delta = date > Date.today ? 0 : 7
    date + delta
  end

end
