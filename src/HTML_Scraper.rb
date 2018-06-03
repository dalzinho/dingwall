require 'nokogiri'
require 'open-uri'
require_relative './MyLogger'

class HTML_Scraper
	attr_reader :doc
	Path = "http://www.nonleaguematters.co.uk/divisions/162"

	def initialize()
		MyLogger.log.info('Initializing scraper')
		@doc = Nokogiri::HTML(open(Path))	
		MyLogger.log.info('Scraped data from ' + Path)
	end

	def get_league_table_info()
		return @doc.xpath("//*[@data-team-id]")
	end

	def get_last_updated()
		return @doc.css("#content p")[3]
	end

end