class Team	
	
	attr_reader :total_points_per_game, 
	:name,
	:total_wins, 
	:total_played,
	:total_points_per_game,
	:total_goal_difference_per_game, 
	:total_possible,
	:standardized_total_points_per_game,
	:standardized_total_goal_difference_per_game,
	:standardized_total_possible,
	:score

	Total_Matches_Per_Season = 22

	def initialize(parsed_object)
		@actual_league_position = parsed_object[:actual_league_position].to_i

		@name = parsed_object[:name]
		
		@home_wins = parsed_object[:home_wins].to_i
		@home_draws = parsed_object[:home_draws].to_i
		@home_losses = parsed_object[:home_losses].to_i
		@home_goals_for = parsed_object[:home_goals_for].to_i
		@home_goals_against = parsed_object[:home_goals_against].to_i

		@away_wins = parsed_object[:away_wins].to_i
		@away_draws = parsed_object[:away_draws].to_i
		@away_losses = parsed_object[:away_losses].to_i
		@away_goals_for = parsed_object[:away_goals_for].to_i
		@away_goals_against = parsed_object[:away_goals_against].to_i

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
		@total_points_per_game
		@total_points_per_game_times_total_league_fixtures

		set_totals()

		@standardized_total_possible
		@standardized_total_goal_difference_per_game
		@standardized_total_points_per_game

		@score
	end

	def set_totals() 
		set_total_wins()
		set_total_draws()
		set_total_losses()
		set_total_goals_for()
		set_total_goals_against()
		set_total_goal_difference()
		set_total_played()
		set_total_goal_difference_per_game()
		set_total_points()
		set_total_possible()
		set_total_points_per_game()
		set_total_points_per_game_times_total_league_fixtures()
	end

	def set_total_wins()
		@total_wins = @home_wins + @away_wins
	end

	def set_total_draws()
		@total_draws = @home_draws + @away_draws
	end

	def set_total_losses()
		@total_losses = @home_losses + @away_losses
	end

	def set_total_goals_for()
		@total_goals_for = @home_goals_for + @away_goals_for
	end

	def set_total_goals_against()
		@total_goals_against = @home_goals_against + @away_goals_against
	end

	def set_total_goal_difference()
		@total_goal_difference = @total_goals_for - @total_goals_against
	end

	def set_total_played()
		@total_played = @total_wins + @total_draws + @total_losses
	end

	def set_total_points()
		win_points = (@home_wins + @away_wins) * 3
		draw_points = @home_draws + @away_draws
		@total_points = win_points + draw_points
	end

	def set_total_goal_difference_per_game()
		@total_goal_difference_per_game = @total_goal_difference.to_f / @total_played / 1
	end

	def set_total_possible()
		@total_possible = (Total_Matches_Per_Season * 3) - (@total_losses * 3) - (@total_draws * 2)
	end

	def set_total_points_per_game()
		@total_points_per_game = @total_points.to_f / @total_played / 1
	end

	def set_total_points_per_game_times_total_league_fixtures()
		@total_points_per_game_times_total_league_fixtures = @total_points_per_game * Total_Matches_Per_Season
	end

	def standardize(target, table_av, table_sd)
		return ((target.to_f - table_av) / table_sd).round(3)
	end

	def set_standardized_total_points_per_game(table_av, table_sd)
		@standardized_total_points_per_game = 
			standardize(@total_points_per_game, table_av, table_sd)	
	end	

	def set_standardized_total_goal_difference_per_game(table_av, table_sd)
		@standardized_total_goal_difference_per_game = standardize(@total_goal_difference_per_game, table_av, table_sd)
	end

	def set_standardized_total_possible(table_av, table_sd)
		@standardized_total_possible = standardize(@total_possible + (@total_possible / @total_points / 1), table_av, table_sd)
	end
	
	def set_score()
		multiplier = 10 * (
			(@standardized_total_points_per_game) 
			+ (@standardized_total_goal_difference_per_game * 0.2)
			+ (@standardized_total_possible * 0.2)
			) / 3
		
		puts @name + multiplier.to_s

		# =(500+(200*((0.2*Q2)+(0.2*R2)+(S2))/3))
		@score = (500 + (200 * multiplier)).round(0)
	end

	def to_hash(options={}) 
		{
			name: @name,
			actual_league_position:	@actual_league_position,
			home_wins: @home_wins,
			home_draws: @home_draws,
			home_losses: @home_losses,
			home_goals_for: @home_goals_for,
			home_goals_against: @home_goals_against,

			away_wins: @away_wins,
			away_draws: @away_draws,
			away_losses: @away_losses,
			away_goals_for: @away_goals_for,
			away_goals_against: @away_goals_against,

			total_played: @total_played,

			total_wins: @total_wins,
			total_draws: @total_draws,
			total_losses: @total_losses,
			total_goals_for: @total_goals_for,
			total_goals_against: @total_goals_against,
			total_goal_difference: @total_goal_difference,
			total_goal_difference_per_game: @total_goal_difference_per_game,
			total_points: @total_points,
			total_possible: @total_possible,
			total_points_per_game: @total_points_per_game,
			total_points_per_game_times_total_league_fixtures: @total_points_per_game_times_total_league_fixtures,

			standardized_total_possible: @standardized_total_possible,
			standardized_total_points_per_game: @standardized_total_points_per_game,
			standardized_total_goal_difference_per_game: @standardized_total_goal_difference_per_game,

			score: @score

		}
	end
end
