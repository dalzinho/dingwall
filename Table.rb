class Table

	attr_reader :ppg_av, :ppg_sd
	attr_accessor :teams
	def initialize(teams)
		@teams =  teams
		@ppg_av = ppg_av()
		@ppg_sd = ppg_sd()		
	end

	# max_score
	#
	
	def max_score()
		return @teams.size * 3
	end

	# ppg_av
	def ppg_av()
		ppg_av = @teams.map {|team| team.ppg()}.reduce(:+)	
		return ppg_av / @teams.size
	end

	def ppg_sd
		mean = ppg_av()

		count = 0
		@teams.each { |team| count += (team.ppg() - mean) ** 2 }

		return Math.sqrt(count)
	end
	#
	# ppg_sd
	#
	# gdpg_av
	#
	# gdpg_sd
	#
	# poss_av
	#
	# poss_sd	
end
