class RacesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @races = Race.all
  end
end
