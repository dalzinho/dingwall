class Table

	attr_reader :ppg_av, :ppg_sd
	attr_accessor :teams

	def initialize(teams)
		@teams =  teams
		@ppg_av = ppg_av()
		@ppg_sd = ppg_sd()		
		@gdpg_av = gdpg_av()
		@gdpg_sd = gdpg_sd()
		@poss_av = poss_av()
		@poss_sd = poss_sd()
	end

def set_team_scores()
	for team in @teams
		puts team.name
		team.set_score(@ppg_av, @ppg_sd, @gdpg_av, @gdpg_sd, @poss_av, @poss_sd)
	end
end
	
	def max_score()
		return ((@teams.size - 1)  * 2) * 3
	end

	# ppg_av
	def ppg_av()
		count = 0.0
		for team in @teams
			count += team.ppg()
		end
		return (count / @teams.size).round(3)
	end

	def ppg_sd
		mean = ppg_av()
		count = 0.0
		for team in @teams
			count += (team.ppg() - mean) ** 2
		end


		return Math.sqrt(count/@teams.size).round(3)
	end
	
	def gdpg_av()
		count = 0.0
		for team in @teams
			count += team.gdpg()
		end
		return (count / @teams.size).round(3)
	end

	def gdpg_sd()
		mean = gdpg_av()
		count = 0.0
		for team in @teams
			count += (team.gdpg() - mean) ** 2
		end


		return Math.sqrt(count/@teams.size).round(3)
	end
	
	def poss_av()
		count = 0.0
		for team in @teams
			count += team.possible(max_score())
			
		end
		return (count / @teams.size).round(3)
	end
	
	def poss_sd
		mean = poss_av()
		count = 0.0
		for team in @teams
			count += (team.possible(max_score()) - mean) ** 2
		end


		return Math.sqrt(count/@teams.size).round(3)
	end	
end
