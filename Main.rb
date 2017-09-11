require './Table'
require './Team'
require './Scraper'

class Main

	def initialize()
		teams = Scraper.getData()
		@table = Table.new(teams)
	end
	
	def display_teams()
		for team in @table.teams
			puts team.name + " | "
		end
	end	
	
end



main = Main.new()
main.display_teams()
