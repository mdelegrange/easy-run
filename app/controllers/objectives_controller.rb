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
      @run = Run.new(
        objective_id: @objective.id,
        race_id: params[:race_id]
      )
      @run.save
      # Suggested Races (distance: semi)
      @race3_semi = suggest_races_semi(@race, 1, 1, 21_100, 21_037).first    
      # Created Run
      create_run(@objective.id, @race3_semi.id)
      @user = current_user
      if @user.level == 'beginner'

        # Suggested Races (distance: 10 km)
        @race1_10km = suggest_races_10km(@race, 6, 5, 10_000).first
        @race2_10km = suggest_races_10km(@race, 3, 2, 10_000).first
        # Created Run
        create_run(@objective.id, @race1_10km.id)
        create_run(@objective.id, @race2_10km.id)
      elsif @user.level == 'intermediate'

        # Suggested Races (distance: 10 km)
        @race1_10km = suggest_races_10km(@race, 4, 3, 10_000).last
        @race2_10km = suggest_races_10km(@race, 3, 2, 10_000).last

        # Created Run
        create_run(@objective.id, @race1_10km.id)
        create_run(@objective.id, @race2_10km.id)
      elsif @user.level == 'advanced'

        # Suggested Races (distance: 10 km)
        @race1_10km = suggest_races_10km(@race, 3, 2, 10_000).first
        @race2_10km = suggest_races_10km(@race, 2, 1, 10_000).last
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
end
