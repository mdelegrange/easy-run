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
      redirect_to objective_runs_path(@objective)
    else
      render :new
    end
  end
end
