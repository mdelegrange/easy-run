class ObjectivesController < ApplicationController

  def index
    @objective = current_user.objectives.last
  end

  def create
    @objective = Objective.new(
      user: current_user,
      race_id: params[:race_id],
      kind: "marathon",
      distance: 42195,
      status: "current"
      )


    if @objective.save
      Run.create(
      objective_id: @objective.id,
      race_id:924
      )
      Run.create(
      objective_id: @objective.id,
      race_id: 1299
      )
      Run.create(
      objective_id: @objective.id,
      race_id:1060
      )

      @run = Run.new(
      objective_id: @objective.id,
      race_id: params[:race_id])
      @run.save

      redirect_to objective_runs_path(@objective)
    else
      render :new
    end
  end
end
