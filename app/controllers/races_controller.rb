class RacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_user, only: [:index, :show]

  def index
    @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }
    if @user.level == "beginner"
    @races = Race.where("distance = ? AND date BETWEEN ? AND ?", @user.targeted_distance, Date.today.beginning_of_month.next_month(11).strftime('%F'), Date.today.end_of_month.next_month(12).strftime('%F'))
    elsif @user.level == "intermediate"
    @races = Race.where("distance = ? AND date BETWEEN ? AND ?", @user.targeted_distance, Date.today.beginning_of_month.next_month(5).strftime('%F'), Date.today.end_of_month.next_month(6).strftime('%F'))
    elsif @user.level == "advanced"
    @races = Race.where("distance = ? AND date BETWEEN ? AND ?", @user.targeted_distance, Date.today.beginning_of_month.next_month(3).strftime('%F'), Date.today.end_of_month.next_month(4).strftime('%F'))
    end
  end

  def show
    @race = Race.find(params[:id])
    @objective = current_user.current_objective
    @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }
    @races = Race.all

    # Race before 1 month of marathon (distance: 21 km) ==> beginner, intermediate and advanced
    @race3_semi = Race.where("date BETWEEN ? AND ? AND distance = ? OR distance = ?", @race.date.beginning_of_month.next_month(-1).strftime('%F'), 
            @race.date.end_of_month.next_month(-1).strftime('%F'), 21_100, 21_037).first

    if @user.level == 'beginner'

    # Race before 6 months of marathon (distance: 10 km)
      @race1_10km = Race.where("date BETWEEN ? AND ? AND distance = ?", @race.date.beginning_of_month.next_month(-6).strftime('%F'), 
        @race.date.end_of_month.next_month(-5).strftime('%F'), 10_000).first

    # Race before 3 months of marathon (distance: 10km)
      @race2_10km = Race.where("date BETWEEN ? AND ? AND distance = ?", @race.date.beginning_of_month.next_month(-3).strftime('%F'), 
        @race.date.end_of_month.next_month(-2).strftime('%F'), 10_000).last
      
    elsif @user.level == 'intermediate'

      # Race before 4 months of marathon (distance: 10 km)
      @race1_10km = Race.where("date BETWEEN ? AND ? AND distance = ?", @race.date.beginning_of_month.next_month(-4).strftime('%F'), 
              @race.date.end_of_month.next_month(-3).strftime('%F'), 10_000).last

      # Race before 3 months of marathon (distance: 10km)
      @race2_10km = Race.where("date BETWEEN ? AND ? AND distance = ?", @race.date.beginning_of_month.next_month(-2).strftime('%F'), 
              @race.date.end_of_month.next_month(-3).strftime('%F'), 10_000).last

      elsif @user.level == 'advanced'

        # Race before 3 months of marathon (distance: 10 km)
        @race1_10km = Race.where("date BETWEEN ? AND ? AND distane = ?", @race.date.beginning_of_month.next_month(-3).strftime('%F'), 
          @race.date.end_of_month.next_month(-2).strftime('%F'), 10_000).first
        # Race before 2 months of marathon (distance: 10km)
        @race2_10km = Race.where("date BETWEEN ? AND ? AND distane = ?", @race.date.beginning_of_month.next_month(-2).strftime('%F'), 
          @race.date.end_of_month.next_month(-1).strftime('%F'), 10_000).first

        # Race before 1 month of marathon (distance: 21 km)
        
      end
  end

  private

  def set_user
    @user = current_user
  end
end
