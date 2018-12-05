class RunsController < ApplicationController

  def show
    @run = Run.find(params[:id])
  end

  def create
    @run = Run.new(run_params)
    @race = Race.find(params[:race_id])
    @run.race = @race
    @run.objective = current_user.current_objective
    @run.status = 'pending'
    if @run.save
      race_runs_path(@race)
    else
      render :new
    end
  end

  def edit
    @run = Run.find(params[:id])
  end

  def update
    @run = Run.find(params[:id])
    @run.update(run_params)
    redirect_to run_path(@run)
  end

  def destroy
    @run = Run.find(params[:id])
    @run.destroy
    redirect_to runs_path
  end
  
  private

  def run_params
    params.require(:run).permit(:targeted_time)
  end
end
