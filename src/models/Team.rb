class Team	
	
	def initialize(parsed_object)
		@name = parsed_object[:name]
		
		@home_wins = parsed_object[:home_wins]
		@home_draws = parsed_object[:home_draws]
		@home_losses = parsed_object[:home_losses]
		@home_goals_for = parsed_object[:home_goals_for]
		@home_goals_against = parsed_object[:home_goals_against]

		@away_wins = parsed_object[:away_wins]
		@away_draws = parsed_object[:away_draws]
		@away_losses = parsed_object[:away_losses]
		@away_goals_for = parsed_object[:away_goals_for]
		@away_goals_against = parsed_object[:away_goals_against]
		@away_points

		@total_played

		@total_wins
		@total_draws
		@total_losses
		@total_goals_for
		@total_goals_against
		@total_goal_difference
		@total_goal_difference_per_game
		@total_points
		@total_possible
		@average_points_per_game
		@average_points_per_game_times_total_league_fixtures

		@standardized_total_possible
		@standardized_total_goal_difference_per_game
		@standardized_total_points_per_game

		@actual_league_position = parsed_object[:actual_league_position]
		
		@score
	end

	def set_totals() 

	end

	def played()
		return @won + @drawn + @lost
	end

	def points()
		win_points = @won * 3
		draw_points = @drawn
		return win_points + draw_points
	end

	def goal_difference()
		return @gfor - @gagainst
	end

	def gdpg()
		played = played()
		goal_difference = goal_difference()
		gdpg = goal_difference.to_f / played
		return gdpg.round(2)
	end

	def ppg()
		return (points().to_f / played).round(2)
	end

	def possible(max_possible)
		subtractor = (3 * @lost) + (2 * @drawn)
		
		return max_possible - subtractor
	end

	def possible_vs_played()
		return possible(66).to_f / played()
	end

	def standardize(target, table_av, table_sd)
		return ((target.to_f - table_av) / table_sd).round(3)
	end

	def stdppg(table_av, table_sd)
		return standardize(ppg(), table_av, table_sd)	
	end	

	def std_gdpg(table_av, table_sd)
		return standardize(gdpg(), table_av, table_sd)
	end

	def std_poss(table_av, table_sd)
		poss_value = possible(66) + possible_vs_played()
		return standardize(poss_value, table_av, table_sd)
	end
	
	def set_score(ppg_av, ppg_sd, gdpg_av, gdpg_sd, poss_av, poss_sd)
		ppg = stdppg(ppg_av, ppg_sd)
		gdpg = std_gdpg(gdpg_av, gdpg_sd)
		poss = std_poss(poss_av, poss_sd)
		
		multiplier = ((ppg) + (gdpg * 0.2) + (poss * 0.2)) / 3
		
		@score =  500 + (200 * multiplier).round(0)
	end

	def hash_me()
		hash = {
			name: @name,
			played: played(),
			won: @won,
			drawn: @drawn,
			lost: @lost,
			gfor: @gfor,
			gagainst: @gagainst,
			gdiff: goal_difference(),
			points: points(),
			ppg: ppg(),
			gdpg: gdpg(),
			poss: possible(66),
			score: @score
		}

		return hash
	end

end















