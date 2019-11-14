require 'pry'

def greeting_and_get_name
	p "Welcome to the MVPAC (Minimal Viable People Adoption Center)."
	p "We specialize in the adoption of domestic cats from licensed breeders."
	puts ""
	puts ""
	p "Enter your name."
	gets.chomp.titleize
end

def make_an_account?
	p "This account does not exist. Would you like you make one?"
	p "Yes or No."
	answer = gets.chomp.titleize
	if answer == "Yes"
		true
	elsif answer != "Yes"
		answer == "No"
	elsif answer == "No"
		false
	end
end

def ask_for_account_name
	p "Enter your name for the owner account."
	p "Your input will be capitalized."
	gets.chomp.titleize
end

def get_breed_from_user
	p "Enter the name of a breed you are interested in."
	gets.chomp.titleize
end

def pick_users_brain
	p "Every breed has stats. Choice which stats of the breed you are interested in."
	p "1 => Temperament"
	p "2 => Life Span"
	p "3 => Description"
	p "4 => Outdoors?"
	p "0 => All available information on the breed."
	puts ""
	# p "Note: You can choose several stats at once."
	# once i implement that, anyway
	gets.chomp.to_i
	# input = gets.chomp.to_i
	# input_arr = []
	# input_arr << input
end

def ask_for_input
	breed = get_breed_from_user
	if get_all(breed)
		case pick_users_brain
		when 1
			get_temperament(breed)
		when 2
			get_life_span(breed)
		when 3
			get_description(breed)
		when 4
			get_indoor(breed)
		when 0
			get_all_scraped(breed)
		else
			p "You must enter a valid integer."
		end
	else
		p "This breed is not in the database."
	end
end

def adopt_a_fresh_cat
end

def adopt_a_previously_existing_cat
end

def change_cats_name
end

def put_cat_up_for_adoption
end
