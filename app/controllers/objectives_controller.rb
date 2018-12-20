class ObjectivesController < ApplicationController
  def index
    @objective = current_user.objectives.last
  end

  def create
    @race = Race.find(params[:race_id])
    @objective = Objective.new(
      user: current_user,
      race_id: params[:race_id],
      kind: Race::DISTANCES[current_user.targeted_distance.to_s],
      distance: current_user.targeted_distance,
      status: "current"
    )
    if @objective.save
      current_user.trainings.last.update(status: 'finished') unless current_user.trainings.last.nil?

      add_races(current_user.level)
      redirect_to objective_runs_path(@objective)
    else
      render 'races/show'
    end
  end

  private

  def create_run(objective, selected_race)
    Run.create(objective_id: objective.id, race_id: selected_race.id, targeted_time: current_user.time_targeted(selected_race), status: 'pending_subscription')
  end

  def suggest_races(month_before_marathon, distance)
    begin_date  = @race.date.beginning_of_month.next_month(- month_before_marathon).strftime('%F')
    end_date    = @race.date.end_of_month.next_month(- month_before_marathon).strftime('%F')
    region      = Race::REGIONS.find { |key, values| values.include?(@race.department) }.first
    departments = Race::REGIONS[region]
    Race.where("date BETWEEN ? AND ? AND distance = ?", begin_date, end_date, distance).where(department: departments)
  end

  def add_races(user_level)
    create_run(@objective, @race)

    @race3_semi = suggest_races(1, 21_097).sample
    create_run(@objective, @race3_semi)

    if user_level == 'DEBUTANT'
      @race1_10km = suggest_races(6, 10_000).first
      @race2_10km = suggest_races(3, 10_000).first
    elsif user_level == 'REGULIER'
      @race1_10km = suggest_races(4, 10_000).first
      @race2_10km = suggest_races(3, 10_000).last
    elsif user_level == 'EXPERT'
      @race1_10km = suggest_races(3, 10_000).first
      @race2_10km = suggest_races(2, 10_000).last
    end

    unless @race1_10km.nil? || @race2_10km.nil?
      create_run(@objective, @race1_10km)
      create_run(@objective, @race2_10km)
    end
  end
end
