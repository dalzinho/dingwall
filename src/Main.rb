require './Table'
require './Team'
require './Scraper'
require 'json'

class Main

	def initialize()

		teams =  File.open("./scraped_data.json","r") do |f|
			JSON.parse(f.read)
		end

		@table = Table.new(parse(teams))

		@table.set_team_scores()


		json_output()

	end
	
	def parse(teams)
		team_array = []

		for team in teams
			object = Team.new(team["name"], team["won"].to_i, team["drawn"].to_i, team["lost"].to_i, team["gfor"].to_i, team["gagainst"].to_i)
			team_array.push(object)
		end

		return team_array
	end

	def json_output
		
		array = []

		for team in @table.teams
			array.push(team.hash_me())
		end

		return array
	end
end


main = Main.new()
