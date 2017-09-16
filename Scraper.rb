require 'nokogiri'
require 'open-uri'
require './Team'
require 'json'

class Scraper

	def self.getData()
		doc = Nokogiri::HTML(open("http://www.nonleaguematters.co.uk/divisions/162"))
		rows = doc.xpath("//*[@data-team-id]")

		File.open("./raw_scrape", 'w') do |f|
			f.write(rows)
		end

		teams = []
		

		details = rows.collect do |row|
			detail = {}

			[
				[:name, 'td[2]/text()'],
				[:won, 'td[4]/text()'],
				[:drawn, 'td[5]/text()'],
				[:lost, 'td[6]/text()'],
				[:gfor, 'td[7]/text()'],
				[:gagainst, 'td[8]/text()']
				].each do |key, xpath|
					detail[key] = row.at_xpath(xpath).to_s.strip	
				end	
				if detail[:name] != ""
					teams.push(detail)		
				end
			end
			
			File.open("./scraped_data.json","w") do |f|
  				f.write(teams.to_json)
			end
		end
	end


	Scraper.getData()


