class RacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_user, only: [:index, :show]

  def index
    @objective = current_user.objectives.last
    @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }

    if @user.level == "DEBUTAT"
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

    # Race before 1 month of marathon (distance: 21 km) ==> debutant, regulier and expert
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
    if @distance == 10_000
      Race.where("date BETWEEN ? AND ? AND distance = ?", @begin_date, @end_date, @distance)
    elsif @distance == 21_100 || @distance == 21_097
      Race.where("date BETWEEN ? AND ? AND distance = ? OR distance = ?", @begin_date, @end_date, 21_000, 21_097)
    end
  end

  def suggest_races_marathon(distance, month_before_marathon)
    @distance = distance
    @month_before_marathon = month_before_marathon
    @begin_date  = Date.today.beginning_of_month.next_month(@month_before_marathon).strftime('%F')
    @end_date    = Date.today.end_of_month.next_month(@month_before_marathon).strftime('%F')
    Race.where("distance = ? AND date BETWEEN ? AND ? ", @distance, @begin_date, @end_date)
  end
end
