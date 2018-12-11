class RunsController < ApplicationController
  before_action :set_run, only: [:show, :edit, :register, :update, :destroy]

  def index
    @objective = current_user.objectives.last
    @runs = current_user.objectives.last.runs.sort_by { |run| run.race.date }
    @race = @objective.race.date
  end

  def show
  end

  def create
    @objective = current_user.objectives.last
    @race = Race.find(params[:race_id])
    @run = Run.new
    @run.race = @race
    @run.objective = @objective
    @run.status = 'pending_subscription'
    @run.save
  end

  def subscribe
    @run.update(status: 'subscribed')
    redirect_to objective_runs_path(@run.objective)
  end

  def skip
    @run.update(status: 'skipped')
    redirect_to objective_runs_path(@run.objective)
  end

  def mark_as_done
    @run.update(status: 'done')
  end

  def edit
    run_date = @run.race.date
    begin_date = run_date.beginning_of_month.next_month(-1)
    end_date = run_date.end_of_month.next_month(1)
    @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }

    if params[:department].nil? || params[:department] == ''
      @switch_runs = Race.where("date BETWEEN ? AND ? AND department = ? AND distance BETWEEN ? AND ?", begin_date, end_date, @run.race.department, 0.5*@run.race.distance, 1.5*@run.race.distance)
    else
      @switch_runs = Race.where("date BETWEEN ? AND ? AND department = ? AND distance BETWEEN ? AND ?", begin_date, end_date, params[:department], 0.5*@run.race.distance, 1.5*@run.race.distance)
    end

  end

  def update
    @run.update(race_id: params[:run][:race].to_i)
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
