class RacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @user = current_user
    @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }
    if @user.level == 'beginner'
      @races = Race.where("distance = ? AND EXTRACT(YEAR FROM date) = ?",  @user.targeted_distance, DateTime.now.next_year(1))
  end

  def show
    @race = Race.find(params[:id])
    @objective = current_user.current_objective
    @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }
    @races = Race.all

    # Race before 4 months of marathon (distance: 10 km)
    @race1_10km_date = (@race.date - (4 * 30))
    @race1_10km = @races.where("extract( month from date) = ? and extract(year from date )= ? and distance = ?",
      @race1_10km_date.month, @race1_10km_date.year, 10_000)
    # Race before 2 months of marathon (distance: 10km)
    @race2_10km_date = (@race.date - (2 * 30))
    @race2_10km = @races.where("extract( month from date) = ? and extract(year from date )= ? and distance = ?",
      @race2_10km_date.month, @race2_10km_date.year, 10_000)

    # Race before 1 month of marathon (distance: 21 km)
    @race3_semi_date = (@race.date - (1 * 30))
    @race3_semi = @races.where("extract( month from date) = ? and extract(year from date )= ? and distance = ?",
      @race3_semi_date.month, @race3_semi_date.year, 21_100)
  end
end
