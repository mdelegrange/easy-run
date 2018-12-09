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

    # Race before 4 months of marathon (distance: 10 km)
    @race1_10km = (@race.date - (4 * 30))
    # Race before 2 months of marathon (distance: 10km)
    @race2_10km = (@race.date - (2 * 30))
    # Race before 1 month of marathon (distance: 21 km)
    @race3_semi = (@race.date - (1 * 30))
  end
end
