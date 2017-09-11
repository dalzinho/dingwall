require 'nokogiri'
require 'open-uri'
require 'json'
require './Team'

class Scraper

	def self.getData()
		doc = Nokogiri::HTML(open("http://www.nonleaguematters.co.uk/divisions/162"))
		puts doc
		rows = doc.xpath("//*[@data-team-id]")
		teams = []
		teams_array = []

		details = rows.collect do |row|
		detail = {}
	[
		[:name, 'td[2]/text()'],
		[:won, 'td[4]/text()'],
		[:drawn, 'td[5]/text()'],
		[:lost, 'td[6]/text()'],
		[:gfor, 'td[7]/text()'],
		[:gagainst, 'td[8]/text()']
	].each do |name, xpath|
			 detail[name] = row.at_xpath(xpath).to_s.strip	
		end
		
		if detail[:name] != ""	
			teams.push(detail)
			teams_array.push(Team.new(detail[:name], detail[:won].to_i, detail[:drawn].to_i, detail[:lost].to_i, detail[:gfor].to_i, detail[:gagainst].to_i))
		end
	end
		File.open("./teams.json", "w") do |f|
						f.write(teams.to_json)
						return teams_array
	end
		
	end
end
