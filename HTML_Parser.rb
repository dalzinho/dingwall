
require './Team'
require 'json'
require './HTML_helper'
require './JSON_Writer'

class HTML_Parser

	def initialize(html_scraper, json_writer)
		@html = html_scraper
		@json = json_writer
	end

	def get_table_data()
		rows = @html.get_league_table_info()
		teams = []
		
		details = rows.collect do |row|
			detail = {}

			[
				[:actual_position, 'td[1]/text()']
				[:name, 'td[2]/text()'],

				[:home_wins, 'td[9]/text()'],
				[:home_draws, 'td[10]/text()'],
				[:home_losses, 'td[11]/text()'],
				[:home_goals_for, 'td[12]/text()'],
				[:home_goals_against, 'td[13]/text()'],

				[:away_wins, 'td[14]/text()'],
				[:away_draws, 'td[15]/text()'],
				[:away_losses, 'td[16]/text()'],
				[:away_goals_for, 'td[17]/text()'],
				[:away_goals_against, 'td[18]/text()'],

				].each do |key, xpath|
					detail[key] = row.at_xpath(xpath).to_s.strip	
				end	
				if detail[:name] != ""
					teams.push(detail)		
				end
			end
			
			return teams
		end

		def get_date_data()
			html_date = @html.get_last_updated()
			date_element = html_date.to_s.match(/(\d{1,2})(th|rd|st|nd)( )([A-Za-z]*)( )(\d{4})/).to_s
			ruby_date = Date.parse(date_element)
			return ruby_date
		end

	end
