class ObjectivesController < ApplicationController

  def index
    @objective = current_user.objectives.last
  end

  def create
    @objective = Objective.new(kind: 'marathon', distance: 42195, status: 'pending')
    @objective.user = current_user
    @marathon = Race.find(params[:race_id])
    @objective.race = @marathon
    if @objective.save
      redirect_to marathons_path
    else
      render :new
    end
  end
end
