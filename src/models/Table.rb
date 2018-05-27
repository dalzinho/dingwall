class Table

	attr_reader :league_average_ppg,
	:league_sd_ppg,
	:league_average_gdpg,
	:league_sd_gdpg,
	:league_average_possible,
	:league_sd_possible

	def initialize(teams)
		@teams = teams
		@league_average_ppg
		@league_sd_ppg		
		@league_average_gdpg
		@league_sd_gdpg
		@league_average_possible
		@league_sd_possible

		set_data()
	end

	def set_data()
		set_league_average_ppg()
		set_league_sd_ppg()
		set_league_average_gdpg()
		set_league_sd_gdpg()
		set_league_average_possible()
		set_league_sd_possible()
	end

	def set_league_average_ppg()
		count = 0.0
		for team in @teams
			count += team.total_points_per_game
		end
		@league_average_ppg = (count / @teams.size / 1).round(3)
	end

	def set_league_sd_ppg()
		count = 0.0
		for team in @teams
			count += (team.total_points_per_game - @league_average_ppg) ** 2
		end
	 	@league_sd_ppg = Math.sqrt(count / @teams.size / 1).round(3)
	end

	def set_league_average_gdpg()
		count = 0.0
		for team in @teams
			count += team.total_goal_difference_per_game
		end
		@league_average_gdpg = (count / @teams.size / 1).round(3)
	end


	def set_league_sd_gdpg()
		count = 0.0
		for team in @teams
			count += (team.total_goal_difference_per_game - @league_average_gdpg) ** 2
		end
	 	@league_sd_gdpg = Math.sqrt(count / @teams.size / 1).round(3)
	end

	def set_league_average_possible()
		count = 0.0
		for team in @teams
			count += (team.total_possible)
		end
		@league_average_possible = (count / @teams.size / 1).round(3)
	end

	def set_league_sd_possible()
		count = 0.0
		for team in @teams
			count += (team.total_possible - @league_average_possible) ** 2
		end
	 	@league_sd_possible = Math.sqrt(count / @teams.size / 1).round(3)
	end
end
