class RacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @user = current_user
    @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }
  	@races = Race.where(distance: @user.targeted_distance )
  end

  def show
    @race = Race.find(params[:id])

    @objective = Objective.create(
      user: current_user,
      race_id: params[@race],
      kind: "marathon",
      distance: 42195,
      status: "current"
      )

    @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }
    @month = @race.date.month
    @races = Race.all


  end
end
