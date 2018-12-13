class RacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_user, only: [:index, :show]

  def index
    @objective = current_user.objectives.last
    @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }
    @regions_full_name = {
      "ara" => "en Auvergne Rhône-Alpes",
      "bfc"=> "en Bourgogne Franche-Comté",
      "b"=> "en Bretagne",
      "cvdl"=> "dans le Centre Val de Loire",
      "c"=> "en Corse",
      "ge"=> "dans le Grand Est",
      "hdf"=> "dans les Hauts de France",
      "idf"=> "en Ile de France",
      "n"=> "en Normandie",
      "na"=> "en Nouvelle Aquitaine",
      "o"=> "en Occitanie",
      "pdll"=> "dans les Pays de la Loire",
      "paca"=> "en Provence Alpes Côte d'Azur"
    }

    if @user.level == "DEBUTANT"
      @races = suggest_races_marathon(@user.targeted_distance, 12)
    elsif @user.level == "REGULIER"
      @races = suggest_races_marathon(@user.targeted_distance, 6)
    elsif @user.level == "EXPERT"
      @races = suggest_races_marathon(@user.targeted_distance, 4)
    end

  end

  def show
    @race = Race.find(params[:id])
    @objective = current_user.objectives.last
    @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }
    @races = Race.all

    # Race before 1 month of marathon (distance: 21 km) ==> DEBUTANT, REGULIER and EXPERT
    @race3_semi = suggest_races(@race, 1, 21_097).first

    if @user.level == 'DEBUTANT'
      # Race before 6 months of marathon (distance: 10 km)
      @race1_10km = suggest_races(@race, 6, 10_000).first
      # Race before 3 months of marathon (distance: 10km)
      @race2_10km = suggest_races(@race, 3, 10_000).first
    elsif @user.level == 'REGULIER'
      # Race before 4 months of marathon (distance: 10 km)
      @race1_10km = suggest_races(@race, 4, 10_000).last
      # Race before 3 months of marathon (distance: 10km)
      @race2_10km = suggest_races(@race, 3, 10_000).first
    elsif @user.level == 'EXPERT'
      # Race before 3 months of marathon (distance: 10 km)
      @race1_10km = suggest_races(@race, 3, 10_000).first
      # Race before 2 months of marathon (distance: 10km)
      @race2_10km = suggest_races(@race, 2, 10_000).last
    end
  end

  private

  def set_user
    @user = current_user
  end

  def suggest_races(race, month_before_marathon, distance)
    @race = race
    @month_before_marathon = month_before_marathon
    @distance    = distance
    @begin_date  = @race.date.beginning_of_month.next_month(- @month_before_marathon).strftime('%F')
    @end_date    = @race.date.end_of_month.next_month(- @month_before_marathon).strftime('%F')
    @region      = Race::REGIONS.find { |key, values| values.include?(@race.department)}.first
    @departments = Race::REGIONS[@region]
    Race.where("date BETWEEN ? AND ? AND distance = ? AND department = ?", @begin_date, @end_date, @distance, @departments)

  end

  def suggest_races_marathon(distance, month_before_marathon)
    @distance = distance
    @month_before_marathon = month_before_marathon
    @begin_date  = Date.today.beginning_of_month.next_month(@month_before_marathon).strftime('%F')
    @end_date    = Date.today.end_of_month.next_month(@month_before_marathon).strftime('%F')
    Race.where("distance = ? AND date BETWEEN ? AND ? ", @distance, @begin_date, @end_date)
  end
end
