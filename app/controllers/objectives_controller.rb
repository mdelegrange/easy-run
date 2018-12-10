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
      
      @race3_semi = Race.where("date BETWEEN ? AND ? AND distance = ? OR distance = ?", @race.date.beginning_of_month.next_month(-1).strftime('%F'), 
      @race.date.end_of_month.next_month(-1).strftime('%F'), 21_100, 21_037).first
      
      @run3_semi = Run.create(
        objective_id: @objective.id,
        race_id: @race3_semi.id
      )
      @user = current_user
        if @user.level == 'beginner'

          # Race before 6 months of marathon (distance: 10 km)
          @race1_10km = Race.where("date BETWEEN ? AND ? AND distance = ?", @race.date.beginning_of_month.next_month(-6).strftime('%F'), 
           @race.date.end_of_month.next_month(-5).strftime('%F'), 10_000).first

          @run1_10km = Run.create(
            objective_id: @objective.id,
            race_id: @race1_10km.id
          )
          # Race before 3 months of marathon (distance: 10km)
          @race2_10km = Race.where("date BETWEEN ? AND ? AND distance = ?", @race.date.beginning_of_month.next_month(-3).strftime('%F'), 
          @race.date.end_of_month.next_month(-2).strftime('%F'), 10_000).first
        
          @run2_10km = Run.create(
            objective_id: @objective.id,
            race_id: @race2_10km.id
          )
        elsif @user.level == 'intermediate'

          #  Race before 4 months of marathon (distance: 10 km)
          @race1_10km = Race.where("date BETWEEN ? AND ? AND distance = ?", @race.date.beginning_of_month.next_month(-4).strftime('%F'), 
          @race.date.end_of_month.next_month(-3).strftime('%F'), 10_000).last

          @run1_10km = Run.create(
            objective_id: @objective.id,
            race_id: @race1_10km.id
          )
          # Race before 3 months of marathon (distance: 10km)
          @race2_10km = Race.where("date BETWEEN ? AND ? AND distance = ?", @race.date.beginning_of_month.next_month(-2).strftime('%F'), 
          @race.date.end_of_month.next_month(-3).strftime('%F'), 10_000).first

          @run2_10km = Run.create(
            objective_id: @objective.id,
            race_id: @race2_10km.id
          )
        elsif @user.level == 'advanced'

          # Race before 3 months of marathon (distance: 10 km)
          @race1_10km = Race.where("date BETWEEN ? AND ? AND distane = ?", @race.date.beginning_of_month.next_month(-3).strftime('%F'), 
          @race.date.end_of_month.next_month(-2).strftime('%F'), 10_000).first
          
          @run1_10km = Run.create(
            objective_id: @objective.id,
            race_id: @race1_10km.id
          )
          # Race before 2 months of marathon (distance: 10km)
          @race2_10km = Race.where("date BETWEEN ? AND ? AND distane = ?", @race.date.beginning_of_month.next_month(-2).strftime('%F'), 
          @race.date.end_of_month.next_month(-1).strftime('%F'), 10_000).last

          @run2_10km = Run.create(
            objective_id: @objective.id,
            race_id: @race2_10km.id
          )      
        end
      redirect_to objective_runs_path(@objective)
    else
      render 'races/show'
    end
  end
end
