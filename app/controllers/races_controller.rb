class RacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @user = current_user
    @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }
  	@races = Race.where(distance: @user.targeted_distance )
  end

  def show
    @race = Race.find(params[:id])

    @objective = current_user.objectives.last

    @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }
    @month = @race.date.month
    @races = Race.all


  end
end
