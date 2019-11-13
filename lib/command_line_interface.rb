# User input goes here with gtes.chomp
# User see text from here
require 'pry'

def greeting
	p "Welcome to the MVPAC (Minimal Viable People Adoption Center)."
	p "We specialize in the adoption of domestic cats from licensed breeders."
	puts ""
	puts ""
end

def get_breed_from_user
	p "Enter the name of a breed you are interested in."
	# breed = gets.chomp.downcase.capitalize
	input = gets.chomp.split(" ").each {|x| x.downcase.capitalize}.join(" ")
	p input 
end

# search_by_breed



# binding.pry
# 0