class RunsController < ApplicationController
  before_action :set_run, only: [:show, :edit, :register, :update, :destroy]

  def index
    @objective = current_user.current_objective
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
  end

  def update
    @run.update(run_params)
    redirect_to run_path(@run)
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
