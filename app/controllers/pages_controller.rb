class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @is_home = params[:controller] == "pages" && params[:action] == "home"
    @race = Race.new
    @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }
  end
end
