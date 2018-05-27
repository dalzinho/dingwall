require './HTML_Scraper'
require './HTML_Parser'


scraper = HTML_Scraper.new()
parser = HTML_Parser.new(scraper)

print parser.get_table_data()