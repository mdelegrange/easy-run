class RunsController < ApplicationController

  before_action :set_run, only: [:show, :edit, :update, :destroy, :subscribe, :mark_as_finished]

  def index
    @objective = current_user.objectives.last
    @runs = current_user.objectives.last.runs.sort_by { |run| run.race.date }
    race = @objective.race

    if current_user.trainings.last.nil?
      @training_plan = nil
    else
      @training_plan = TrainingPlan.find(Training.find(current_user.training_ids).first.training_plan_id)
      @today = DateTime.now
      if current_user.trainings.last.begin_date > Date.today
        @week = params[:week] ? params[:week].to_i : 1
      else
        begin_date = (Date.parse('monday') - current_user.trainings.last.begin_date).to_i / 7
        @week = params[:week] ? params[:week].to_i : begin_date
      end
      @prev_week = @week - 1 if @week > 1
      @next_week = @week + 1 if @week < 18
    end

  end

  def new
    @objective = current_user.objectives.last
    races = Race.all
    @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }
    @distances_options = Race::DISTANCES.map { |label, value| [value, label] }

    if params[:department].nil? && params[:distance].nil?
      @races_to_display = []
    else
      @races_to_display = races.where(department: params[:department].to_i).where(distance: params[:distance].to_i)
    end
  end

  def create
    @objective = current_user.objectives.last
    @race = Race.find(params[:race_id])
    @run = Run.new
    @run.race = @race
    @run.objective = @objective
    @run.status = 'pending_subscription'
    @run.targeted_time = current_user.time_targeted(@race)
    @run.save
    redirect_to objective_runs_path(@objective)
  end

  def subscribe
    @run.update(status: 'subscribed')
    @run.save
    redirect_to objective_runs_path(@run.objective)
  end

  def skip
    @run.update(status: 'skipped')
    redirect_to objective_runs_path(@run.objective)
  end

  def mark_as_finished
    final_time = params[:run][:final_hours].to_i * 3_600 + params[:run][:final_minutes].to_i * 60 + params[:run][:final_seconds].to_i
    @run.update(final_time: final_time)
    @run.update(status: 'finished')
    @run.save
    redirect_to objective_runs_path(@run.objective)
  end

  def edit
    run_date    = @run.race.date
    begin_date  = run_date.beginning_of_month.next_month(-2)
    end_date    = run_date.end_of_month.next_month(2)
    region      = Race::REGIONS.find { |key, values| values.include?(@run.race.department) }.first
    departments = Race::REGIONS[region]

    @switch_runs = Race.where("date BETWEEN ? AND ? AND distance BETWEEN ? AND ?", begin_date, end_date, 0.75*@run.race.distance, 1.25*@run.race.distance).where(department: departments).where.not(id: @run.race.id)
  end

  def update
    @run.update(race_id: params[:run][:race].to_i, status: 'pending_subscription')
    redirect_to objective_runs_path(current_user.objectives.last)
  end

  def destroy
    @run.destroy
    redirect_to runs_path
  end

  private

  def run_params
    params.require(:run).permit(:targeted_time)
  end

  def set_run
    @run = current_user.runs.find(params[:id])
  end
end
