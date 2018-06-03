require 'logger'
require 'date'

class MyLogger

  def self.log
    if @logger.nil?
      @logger = Logger.new('./log/' + Date.today.to_s + 'scraper_log.log')
      @logger.level = Logger::DEBUG
      @logger.datetime_format = '%Y-%m-%d %H:%M:%S '
    end
    @logger
  end

end