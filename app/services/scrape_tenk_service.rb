class ScrapeTenkService
  def call
    tenk_urls = ['http://bases.athle.com/asp.net/liste.aspx?frmpostback=true&frmbase=calendrier&frmmode=1&frmespace=0&frmsaison=2019&frmtype1=&frmtype2=&frmtype3=HS+-+10km+route&frmtype4=&frmniveau=&frmniveaulab=&frmligue=&frmdepartement=&frmepreuve=&frmdate_j1=01&frmdate_m1=01&frmdate_a1=2019&frmdate_j2=31&frmdate_m2=12&frmdate_a2=2019&frmposition=0', 'http://bases.athle.com/asp.net/liste.aspx?frmpostback=true&frmbase=calendrier&frmmode=1&frmespace=0&frmsaison=2019&frmtype1=&frmtype2=&frmtype3=HS+-+10km+route&frmtype4=&frmniveau=&frmniveaulab=&frmligue=&frmdepartement=&frmepreuve=&frmdate_j1=01&frmdate_m1=01&frmdate_a1=2019&frmdate_j2=31&frmdate_m2=12&frmdate_a2=2019&frmposition=1', 'http://bases.athle.com/asp.net/liste.aspx?frmpostback=true&frmbase=calendrier&frmmode=1&frmespace=0&frmsaison=2019&frmtype1=&frmtype2=&frmtype3=HS+-+10km+route&frmtype4=&frmniveau=&frmniveaulab=&frmligue=&frmdepartement=&frmepreuve=&frmdate_j1=01&frmdate_m1=01&frmdate_a1=2019&frmdate_j2=31&frmdate_m2=12&frmdate_a2=2019&frmposition=2']
    races = []

    tenk_urls.each do |tenk_url|
      doc = Nokogiri::HTML(open(tenk_url).read)
      races_list = doc.search("tr")
      races_list.each do |race|
        unless race.search("td a[title='cliquez pour le détail']").text == ""
          url = 'http://bases.athle.com/asp.net/competitions.aspx?base=calendrier&id=' + race.search("a[title='cliquez pour le détail']")[0].attributes['href'].value.match(/\d\d*/)[0]

          race_info = {
            race_name: race.search("td a[title='cliquez pour le détail']").text,
            race_url: url,
            # race_date: race.search("a[title='Toutes les compétitions de ce jour']").text + '/2019',
            race_dpt: race.search("a[title='Toutes les compétitions de ce département pour 15 jours avant et 15 jours après']").text.to_i
          }
          details = scrape_tenk_details(url)

          races << race_info.merge!(details)
        end
      end
    end

    return races
  end

  def scrape_tenk_details(url)
    race_details = {}
    races = []

    doc = Nokogiri::HTML(open(url).read)
    race_details[:race_date] = doc.search("span[style='color:#A00014']").text

    list_items = doc.search('tr')
    list_items.each do |list_item|
      if list_item.search('td').first.text == 'Organisateur'
        race_details[:organisateur] = list_item.search('td').last.text
      end
      if list_item.search('td').first.text == 'Site Web'
        race_details[:site_web] = list_item.search('td').last.text
      end
      if list_item.search('td').first.text == 'Engagement en ligne'
        race_details[:subscription_form] = list_item.search('td').last.text
      end
    end

    tests = doc.search("b")

    tests.each do |test|
      if test.text == "LISTE DES ÉPREUVES"
        lists = test.parent.next_element.search("tr > td > table > tr")
        lists.each do |list|
          unless list.search('td:nth-child(3) b').text == ""
            race_detail_info = {}
            race_detail_info[:race_name] = list.search('td:nth-child(3) b').text
            if list.search('td:nth-child(5)').text.gsub(' m', '').to_i == 21100
              race_detail_info[:race_distance] = 21097
            else
              race_detail_info[:race_distance] = list.search('td:nth-child(5)').text.gsub(' m', '').to_i
            end
            unless list.next_element.nil?
              unless list.next_element.search('tr').first.nil?
                if list.next_element.search('tr').first.text.first(7) == 'Montant'
                  race_detail_info[:price] = list.next_element.search('tr').first.text.gsub('Montant Inscription:', '')
                end
              end
            end
            races << race_detail_info
          end
        end
      end
    end

    race_details[:races_list] = races

    return race_details
  end
end
