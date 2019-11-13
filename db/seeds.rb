# require 'rest-client'
# require 'json'
# require 'pry'
# require_relative '../config/environment'
# require_all 'app'

# require_relative '../app/models/cat.rb'

# url = "https://api.thecatapi.com/v1/breeds"
# response = RestClient.get(url)
# cats = JSON.parse(response)


# cats.each do |cat|
# 	p "Breed: " + cat["name"]
# 	p "Temperament: " + cat["temperament"]
# 	p "Life Span: " + cat["life_span"]
# 	p "Descripton: " + cat["description"]
# 	p "An Indoor Breed?: " + "#{cat["indoor"]}"

# 	Cat.create(name: cat["name"],
# 		temperament: cat["temperament"],
# 		life_span: cat["life_span"],
# 		description: cat["description"],
# 		indoor: cat["indoor"]
# 	)
# end


# binding.pry
# 0
