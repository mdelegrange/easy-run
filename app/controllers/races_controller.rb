class RacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_user, only: [:index, :show]

  def index
    @objective = current_user.objectives.last
    @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }
    if @user.level == "beginner"
    @races = suggest_races_marathon(@user.targeted_distance, 11, 12)
    elsif @user.level == "intermediate"
    @races =suggest_races_marathon(@user.targeted_distance, 5, 6)
    elsif @user.level == "advanced"
    @races = suggest_races_marathon(@user.targeted_distance, 3, 4)
    end
  end

  def show
    @race = Race.find(params[:id])
    @objective = current_user.objectives.last
    @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }
    @races = Race.all

    # Race before 1 month of marathon (distance: 21 km) ==> beginner, intermediate and advanced
    @race3_semi = suggest_races_semi(@race, 1, 1, 20_100, 20_037).first

    if @user.level == 'beginner'
      # Race before 6 months of marathon (distance: 10 km)
      @race1_10km = suggest_races_10km(@race, 6, 5, distance).first
      # Race before 3 months of marathon (distance: 10km)
      @race2_10km = suggest_races_10km(@race, 3, 2, 10_000).first
    elsif @user.level == 'intermediate'
      # Race before 4 months of marathon (distance: 10 km)
      @race1_10km = suggest_races_10km(@race, 4, 3, 10_000).last
      # Race before 3 months of marathon (distance: 10km)
      @race2_10km = suggest_races_10km(@race, 2, 3, 10_000)
    elsif @user.level == 'advanced'
      # Race before 3 months of marathon (distance: 10 km)
      @race1_10km = suggest_races_10km(@race, 3, 2, distance).first
      # Race before 2 months of marathon (distance: 10km)
      @race2_10km = suggest_races_10km(@race, 2, 1, 10_000).last
    end
  end

  private

  def set_user
    @user = current_user
  end

  def suggest_races_10km(race, first_month, last_month, distance)
    @race        = race
    @first_month = first_month
    @last_month  = last_month
    @distance    = distance
    @begin_date  = @race.date.beginning_of_month.next_month(- @first_month).strftime('%F')
    @end_date    = @race.date.end_of_month.next_month(-@last_month).strftime('%F')
    Race.where("date BETWEEN ? AND ? AND distance = ?", @begin_date, @end_date, @distance)
  end

  def suggest_races_semi(race, first_month, last_month, distance1, distance2)
    @race        = race
    @first_month = first_month
    @last_month  = last_month
    @distance1   = distance1
    @distance2   = distance2
    @begin_date  = @race.date.beginning_of_month.next_month(- @first_month).strftime('%F')
    @end_date    = @race.date.end_of_month.next_month(-@last_month).strftime('%F')
    Race.where("date BETWEEN ? AND ? AND distance = ? OR distance = ?", @begin_date, @end_date, @distance1, @distance2)
  end

  def suggest_races_marathon(distance, first_month, last_month)
    @distance    = distance
    @first_month = first_month
    @last_month  = last_month
    @begin_date  = Date.today.beginning_of_month.next_month(@first_month).strftime('%F')
    @end_date    = Date.today.end_of_month.next_month(@last_month).strftime('%F')
    Race.where("distance = ? AND date BETWEEN ? AND ? ", @distance, @begin_date, @end_date)
  end
end
