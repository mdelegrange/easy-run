class RacesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @user = current_user
  	@races = Race.where(distance: @user.targeted_distance, department: params[:department] )
  end
end
