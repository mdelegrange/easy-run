class Trainings::SessionsController < ApplicationController

  def show
    @session = TrainingSession.find(params[:id])
  end
end
