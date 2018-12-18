class RacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @objective = current_user.objectives.last
    @departments_options = Race::DEPARTMENTS.map { |label, value| [label, value] }
    @regions_full_name = {
      "ara" => "en Auvergne Rhône-Alpes",
      "bfc"=> "en Bourgogne Franche-Comté",
      "b"=> "en Bretagne",
      "cvdl"=> "dans le Centre Val de Loire",
      "c"=> "en Corse",
      "ge"=> "dans le Grand Est",
      "hdf"=> "dans les Hauts de France",
      "idf"=> "en Ile de France",
      "n"=> "en Normandie",
      "na"=> "en Nouvelle Aquitaine",
      "o"=> "en Occitanie",
      "pdll"=> "dans les Pays de la Loire",
      "paca"=> "en Provence Alpes Côte d'Azur"
    }

    if current_user.targeted_distance > 22000
      if current_user.level == "DEBUTANT"
        races = suggest_races(current_user.targeted_distance, 12)
      elsif current_user.level == "REGULIER"
        races = suggest_races(current_user.targeted_distance, 6)
      elsif current_user.level == "EXPERT"
        races = suggest_races(current_user.targeted_distance, 4)
      end
    else
      if current_user.level == "DEBUTANT"
        races = suggest_races(current_user.targeted_distance, 8)
      elsif current_user.level == "REGULIER"
        races = suggest_races(current_user.targeted_distance, 6)

      elsif current_user.level == "EXPERT"
        races = suggest_races(current_user.targeted_distance, 3)
      end
    end


    if params[:region].nil?
      @races_to_display = races
    else
      @races_to_display = races.where(department: Race::REGIONS[params[:region]])
    end

  end

  private

  def suggest_races(distance, month_before)
    @begin_date  = Date.today.beginning_of_month.next_month(month_before).strftime('%F')
    @end_date    = Date.today.end_of_month.next_month(month_before).strftime('%F')
    Race.where("distance = ? AND date BETWEEN ? AND ? ", distance, @begin_date, @end_date)
  end
end
