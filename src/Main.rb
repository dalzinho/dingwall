require_relative 'HTML_Scraper'
require_relative 'HTML_Parser'
require_relative 'models/Team'
require_relative 'models/Table'
require 'json'

scraper = HTML_Scraper.new()
parser = HTML_Parser.new(scraper)
team_data = parser.get_table_data()
teams = team_data.map { |team| Team.new(team)}
table = Table.new(teams)

for team in teams
	team.set_standardized_total_points_per_game(table.league_average_ppg, table.league_sd_ppg)
	team.set_standardized_total_goal_difference_per_game(table.league_average_gdpg, table.league_sd_gdpg)
	team.set_standardized_total_possible(table.league_average_possible, table.league_sd_possible)
	team.set_score()
end

output = {
	update: parser.get_date_data,
	teams: teams.map {|team| team.to_hash}
}

f = File.open(__dir__ + '/data/' + output[:update].to_s + 'data', 'w')
	f.write(output.to_json)
f.close