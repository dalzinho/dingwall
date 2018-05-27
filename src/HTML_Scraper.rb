require 'nokogiri'
require 'open-uri'

class HTML_Scraper
	attr_reader :doc

	def initialize()
		@doc = Nokogiri::HTML(open("http://www.nonleaguematters.co.uk/divisions/162"))
	end

	def get_league_table_info()
		return @doc.xpath("//*[@data-team-id]")
	end

	def get_last_updated()
		return @doc.css("#content p")[3]
	end

end