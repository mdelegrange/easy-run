class ObjectivesController < ApplicationController

  def index
    @objective = current_user.objectives.last
  end

  def create
    @race = Race.find(params[:race_id])
    @objective = Objective.new(
      user: current_user,
      race_id: params[:race_id],
      kind: "marathon",
      distance: 42_195,
      status: "current"
    )
    if @objective.save
      create_run(@objective.id, params[:race_id])
      # Suggested Races (distance: semi)
      @race3_semi = suggest_races(@race, 1, 21_100).first
      # Created Run
      create_run(@objective.id, @race3_semi.id)
      @user = current_user
      if @user.level == 'beginner'

        # Suggested Races (distance: 10 km)
        @race1_10km = suggest_races(@race, 6, 10_000).first
        @race2_10km = suggest_races(@race, 3, 10_000).first
        # Created Run
        create_run(@objective.id, @race1_10km.id)
        create_run(@objective.id, @race2_10km.id)
      elsif @user.level == 'intermediate'

        # Suggested Races (distance: 10 km)
        @race1_10km = suggest_races(@race, 4, 10_000).last
        @race2_10km = suggest_races(@race, 3, 10_000).last

        # Created Run
        create_run(@objective.id, @race1_10km.id)
        create_run(@objective.id, @race2_10km.id)
      elsif @user.level == 'advanced'

        # Suggested Races (distance: 10 km)
        @race1_10km = suggest_races(@race, 3, 10_000).first
        @race2_10km = suggest_races(@race, 2, 10_000).last
        # Create Run
        create_run(@objective.id, @race1_10km.id)
        create_run(@objective.id, @race2_10km.id)
      end
      redirect_to objective_runs_path(@objective)
    else
      render 'races/show'
    end
  end

  private

  def create_run(object_id, race_id)
    @object_id = object_id
    @race_id = race_id
    Run.create(objective_id: @object_id, race_id: @race_id)
  end

  def suggest_races(race, month_before_marathon, distance)
    @race = race
    @month_before_marathon = month_before_marathon
    @distance    = distance
    @begin_date  = @race.date.beginning_of_month.next_month(- @month_before_marathon).strftime('%F')
    @end_date    = @race.date.end_of_month.next_month(- @month_before_marathon).strftime('%F')
    if @distance == 10_000
      Race.where("date BETWEEN ? AND ? AND distance = ?", @begin_date, @end_date, @distance)
    elsif @distance == 21_100 || @distance == 21_087
      Race.where("date BETWEEN ? AND ? AND distance = ? OR distance = ?", @begin_date, @end_date, 21_100, 21_087)
    end
  end
end
