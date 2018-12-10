class AddRacesToDBService
  def call
    races_info = ScrapeMarathonsService.new.call
    races_info.each do |race_info|
      if Race.where(event_name: race_info[:race_name]).exists?
        puts "Race already created"
      else
        race_info[:races_list].each do |race|
          Race.create!({
            name: race[:race_name],
            date: Date.strptime(race_info[:race_date], "%d/%m/%Y"),
            distance: race[:race_distance],
            event_name: race_info[:race_name],
            department: race_info[:race_dpt],
            url:race_info[:site_web],
            price: race[:price]
          })
        end
      end
    end

    semis_info = ScrapeSemisService.new.call
    semis_info.each do |race_info|
      if Race.where(event_name: race_info[:race_name]).exists?
        puts "Race already created"
      else
        race_info[:races_list].each do |race|
          Race.create!({
            name: race[:race_name],
            date: Date.strptime(race_info[:race_date], "%d/%m/%Y"),
            distance: race[:race_distance],
            event_name: race_info[:race_name],
            department: race_info[:race_dpt],
            url:race_info[:site_web],
            price: race[:price]
          })
        end
      end
    end
  end
end
