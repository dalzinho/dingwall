require 'minitest/autorun'
require 'minitest/rg'
require './Team'

class TestTeam < MiniTest::Test

	def setup()
		@pollok = Team.new(1,1,2,6,8, 66)
	end

	def test_teamHasPlayedSixGames()
		assert_equal(4, @pollok.played())
	end

	def test_teamHasElevenPoints()
		assert_equal(4, @pollok.points())
	end

	def test_goalDifferenceIsFour()
		assert_equal(-2, @pollok.goal_difference())
	end

	def test_calculatesGdpg()
		assert_equal(-0.5, @pollok.gdpg())
	end

	def test_ppgIsOnePointEightThree()
		assert_equal(1, @pollok.ppg())
	end

	def test_possibleIs59()
		assert_equal(58, @pollok.possible())
	end

	def test_poss_vs_played()
		assert_equal(14.5, @pollok.possible_vs_played())
	end

	def test_averagePPGis1point83_stdppgis0()
		stdppg = @pollok.stdppg(1.461, 0.794)
		assert_equal(-0.581, stdppg)
	end

	def test_averageGDPGis0point67_stdgdpgis0()
		stdgdpg = @pollok.std_gdpg(0, 1.268)
		assert_equal(-0.394, stdgdpg)
	end

	def test_averagePossIs59_stdPossIs0()
		std_poss = @pollok.std_poss(60.083, 3.068)
		assert_equal(4.047, std_poss)
	end

	def test_calculatesScore()
		score = @pollok.score(1.461, 0.794, 0, 1.268, 60.083, 3.068).round(0)
		assert_equal(510, score)
	end

end
