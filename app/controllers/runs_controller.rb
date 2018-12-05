class RunsController < ApplicationController
  before_action :set_run, only: [:show, :edit, :register, :update, :destroy]

  def show
  end

  def create
    @run = Run.new(run_params)
    @race = Race.find(params[:race_id])
    @run.race = @race
    @run.objective = current_user.current_objective
    @run.status = 'pending_subscription'
    if @run.save
      race_runs_path(@race)
    else
      render :new
    end
  end

  def subcribe
    @run.update(status: 'subscribed')
    redirect_to objective_runs_path(@run.objective)
  end

  def mark_as_done
    @run.update(status: 'done')
    redirect_to objective_runs_path(@run.objective)
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
