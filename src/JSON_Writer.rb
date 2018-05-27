class JSON_Writer

	def write(object)
		File.open("./scraped_data.json","w") do |f|
  		f.write(object.to_json)
		end
	end

end
