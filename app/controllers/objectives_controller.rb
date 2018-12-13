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
      create_training
      create_run(@objective.id, params[:race_id], @race)
      # Suggested Races (distance: semi)
      @race3_semi = suggest_races(1, 21_097).first
      # Created Run
      create_run(@objective.id, @race3_semi.id, @race3_semi)
      @user = current_user
      if @user.level == 'DEBUTANT'

        # Suggested Races (distance: 10 km)
        @race1_10km = suggest_races(6, 10_000).first
        @race2_10km = suggest_races(3, 10_000).first
        unless @race1_10km.nil? || @race2_10km.nil?
          # Created Run
          create_run(@objective.id, @race1_10km.id, @race1_10km)
          create_run(@objective.id, @race2_10km.id, @race2_10km)
        end
      elsif @user.level == 'REGULIER'

        # Suggested Races (distance: 10 km)
        @race1_10km = suggest_races(4, 10_000).first
        @race2_10km = suggest_races(3, 10_000).last
        unless @race1_10km.nil? || @race2_10km.nil?
          # Created Run
          create_run(@objective.id, @race1_10km.id, @race1_10km)
          create_run(@objective.id, @race2_10km.id, @race2_10km)
        end
      elsif @user.level == 'EXPERT'

        # Suggested Races (distance: 10 km)
        @race1_10km = suggest_races(3, 10_000).first
        @race2_10km = suggest_races(2, 10_000).last
        unless @race1_10km.nil? || @race2_10km.nil?
          # Create Run
          create_run(@objective.id, @race1_10km.id, @race1_10km)
          create_run(@objective.id, @race2_10km.id, @race2_10km)
        end
      end
      redirect_to objective_runs_path(@objective)
    else
      render 'races/show'
    end
  end

  private

  def create_training
    Training.create(
      user_id: current_user.id,
      training_plan_id: TrainingPlan.first.id,
      begin_date: @race.date - 126,
      status: 'current'
      )
  end

  def create_run(object_id, race_id, race_selected)
    @object_id = object_id
    @race_id = race_id
    @race_selected = race_selected
    Run.create(objective_id: @object_id, race_id: @race_id, targeted_time: current_user.time_targeted(@race_selected), status: 'pending_subscription')
  end

  def suggest_races(month_before_marathon, distance)
    @month_before_marathon = month_before_marathon
    @distance    = distance
    @begin_date  = @race.date.beginning_of_month.next_month(- @month_before_marathon).strftime('%F')
    @end_date    = @race.date.end_of_month.next_month(- @month_before_marathon).strftime('%F')
    region      = Race::REGIONS.find { |key, values| values.include?(@race.department) }.first
    departments = Race::REGIONS[region]
    Race.where("date BETWEEN ? AND ? AND distance = ?", @begin_date, @end_date, @distance).where(department: departments)

  end
end
