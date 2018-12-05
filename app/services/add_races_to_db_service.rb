class AddRacesToDBService
  def call
    races_info = ScrapeMarathonsService.new.call
    races_info.each do |race_info|
      if Race.where(event_name: race_info[:race_name]).exists?
        puts "Race already created"
      else
        race_info[:races_list].each do |race|
          Race.create({
            name: race[:race_name],
            date: race_info[:race_date],
            distance: race[:race_distance],
            event_name: race_info[:race_name],
            department: race_info[:race_dpt],
            url:race_info[:race_url]
          })
        end
      end
    end
  end
end
