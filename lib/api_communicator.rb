require 'rest-client'
require 'json'
require 'pry'
require_relative '../config/environment'
require_all 'app'

def cats_database
	url = "https://api.thecatapi.com/v1/breeds"
	response = RestClient.get(url)
	cats = JSON.parse(response)
end

def get_all(breed)
	cats_database.find {|cat| cat["name"] == breed}
end

def get_breed_name(breed)
	breed_name = get_all(breed).find {|cat| cat[0]["name"]}[1]
end

def get_temperament(breed)
	temperament = get_all(breed).find {|cat| cat[0]["temperament"]}[1]
end

def get_life_span(breed)
	life_span = get_all(breed).find {|cat| cat[0]["life_span"]}[1]
end

def get_description(breed)
	description = get_all(breed).find {|cat| cat[0]["description"]}[1]
end

def get_indoor(breed)
	indoor_t_or_f = get_all(breed).find {|cat| cat[0]["indoor"]}[1]
end


# binding.pry
# 0
