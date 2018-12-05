class RunsController < ApplicationController

  def create
  	@run = Run.new(run_params)
  	@race = Race.find(params[:race_id])
  	@run.race = @race
  	@run.objective = current_user.pending_objective
  	@run.status = 'pending'
  	if @run.save
  	  race_runs_path(@race)
  	else
  	  render :new
  	end
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
