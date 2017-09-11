class Team

	attr_reader :name, :won, :drawn, :lost, :gfor, :gagainst, :score			
	attr_accessor :score


	def initialize(name, won, drawn, lost, gfor, gagainst)
@name = name
		@won = won
		@drawn = drawn
		@lost = lost
		@gfor = gfor
		@gagainst = gagainst
		@max_possible
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

	def possible()
		subtractor = (3 * @lost) + (2 * @drawn)
		
		return @max_possible - subtractor
	end

	def possible_vs_played()
		return possible().to_f / played()
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
					poss_value = possible() + possible_vs_played()
		return standardize(poss_value, table_av, table_sd)
	end
	
	def score(ppg_av, ppg_sd, gdpg_av, gdpg_sd, poss_av, poss_sd)
		ppg = stdppg(ppg_av, ppg_sd)
		gdpg = std_gdpg(gdpg_av, gdpg_sd)
		poss = std_poss(poss_av, poss_sd)
		
		multiplier = ((ppg) + (gdpg * 0.2) + (poss * 0.2)) / 3
		
		return 500 + (200 * multiplier)
	end

end















