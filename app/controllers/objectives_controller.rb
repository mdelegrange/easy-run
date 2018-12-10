class ObjectivesController < ApplicationController

  def index
    @objective = current_user.objectives.last
  end

  def create
    @race = Race.find(params[:race_id])
    @objective = Objective.new(
      user: current_user,
      race_id: params[:race_id],
      kind: "marathon",
      distance: 42_195,
      status: "current"
    )
    if @objective.save
      @run = Run.new(
        objective_id: @objective.id,
        race_id: params[:race_id]
      )
      @run.save
      redirect_to race_path(@race)
    else
      render 'races/show'
    end
  end
end
