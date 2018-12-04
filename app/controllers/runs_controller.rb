class RunsController < ApplicationController

  def create
  	@run = Run.new(status: 'pending')
  	@race = Race.find(params[:race_id])
  	@run.race = @race
  	@run.objective = @race.objective
  end
end
