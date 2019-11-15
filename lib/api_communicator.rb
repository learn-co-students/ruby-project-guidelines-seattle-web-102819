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

def get_breed_list
	list = cats_database.map {|cat| cat["name"]}
	list.each do |breed|
		p breed
	end
end

def get_all(breed)
	cats_database.find {|cat| cat["name"] == breed}
end

def get_breed_name(breed)
	breed_name = get_all(breed).find {|cat| cat[0]["name"]}[1]
end

def get_temperament(breed)
	temperament = get_all(breed).find {|cat| cat[0]["temperament"]}[1]
	puts ""
	p "The #{breed}'s temperament includes: " + temperament + "."
end

def get_life_span(breed)
	life_span = get_all(breed).find {|cat| cat[0]["life_span"]}[1]
	puts ""
	p "The #{breed}'s life span is " + life_span + " years."
end

def get_description(breed)
	description = get_all(breed).find {|cat| cat[0]["description"]}[1]
	puts ""
	p description
end

def get_indoor(breed)
	indoor_t_or_f = get_all(breed).find {|cat| cat[0]["indoor"]}[1]
	if indoor_t_or_f == 0
		puts ""
		p "The #{breed} is an outdoor breed."
	elsif indoor_t_or_f == 1
		puts ""
		p "The #{breed} is an indoor breed."
	end
end

def get_all_scraped(breed)
	get_temperament(breed)
	get_life_span(breed)
	get_description(breed)
	get_indoor(breed)
end
