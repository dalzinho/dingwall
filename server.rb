require('sinatra')
require('sinatra/json')
require('sinatra/contrib')
require('./Main')

main = Main.new()

before do
    content_type 'application/json'
  end

get '/' do
	JSON.pretty_generate(main.json_output())
end