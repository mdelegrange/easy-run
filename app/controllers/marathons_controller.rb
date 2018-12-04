class MarathonsController < ApplicationController

  skip_before_action :authenticate_user!
  def index
  	@marathons = Race.where("distance >= 42195")
  end
end
