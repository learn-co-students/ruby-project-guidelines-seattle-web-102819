require 'pry'
require 'date'

class CLIMethods

	def self.make_space(num)
		num.times do
			puts ""
		end
	end
	
	def self.mvpac_title
		make_space(47)
		puts "________________________________________"
		puts "| Minimal Viable People Adoption Center |"
		puts "________________________________________"
		make_space(50)
	end

	# def self.verified_owner?
	# 	name = greeting_and_get_name
	# 	owner = Owner.find {|owner| owner["name"] == name}
	# 	if owner
	# 		true
	# 		puts "Welcome, #{name}."
	# 	elsif !owner && make_an_account?
	# 		false
	# 		new_account_name = ask_for_new_account_name
	# 		if !(Owner.find {|owner| owner["name"] == new_account_name})
	# 		Owner.create(name: new_account_name)
	# 		puts "Welcome, #{new_account_name}."
	# 		end
	# 	end
	# end

	def self.main_menu
		puts "[1] => Learn about a particular breed of cat."
		puts ""
		puts "[2] => Adopt a kitten."
		puts ""
		puts "[3] => Update a your cat's name from in records."
		puts ""
		puts "[4] => Put your cat up for adoption."
		puts ""
		puts "[0] => Exit the program."
		puts ""

		while true
			input = gets.chomp
			if input == "1"
				user_breed_search
				break
			elsif input == "2"
				adopt_a_fresh_cat
				break
			elsif input == "3"
				change_cats_name
				break
			elsif input == "4"
				put_cat_up_for_adoption
				break
			elsif input == "0"
				break
			else
				"Command not found."
			end
		end
	end

	def self.greeting_and_get_name
		puts "Welcome to the MVPAC."
		puts "We specialize in the adoption of domestic cats from licensed breeders."
		puts ""
		puts ""
		puts "Enter your name."
		gets.chomp.titleize
	end
	
	def self.make_an_account?
		puts "This account does not exist. Would you like you make one?"
		puts "Yes or No."
		answer = gets.chomp.titleize
		if answer == "Yes"
			true
		elsif answer == "No"
			false
		end
	end
	
	def self.ask_for_new_account_name
		puts "Enter your name."
		puts "Your input will be capitalized."
		gets.chomp.titleize
	end
	
	def self.get_breed_from_user
		puts "Enter the name of a breed you are interested in."
		gets.chomp.titleize
	end

	def self.pick_users_brain
		puts "Every breed has stats. Choice which stats of the breed you are interested in."
		puts "[9] => All available information on the breed."
		puts "[1] => Temperament"
		puts "[2] => Life Span"
		puts "[3] => Description"
		puts "[4] => Outdoors?"
		puts "[0] => Return."
		puts ""
		# p "Note: You can choose several stats at once."
		# once i implement that, anyway
		gets.chomp
		# input = gets.chomp.to_i
		# input_arr = []
		# input_arr << input
	end

	def self.ask_for_input
		breed = get_breed_from_user
		if get_all(breed)
			case pick_users_brain
			when "1"
				get_temperament(breed)
			when "2"
				get_life_span(breed)
			when "3"
				get_description(breed)
			when "4"
				get_indoor(breed)
			when "9"
				get_all_scraped(breed)
			when "0"
				main_menu
			else
				p "You must enter a valid integer."
			end
		else
			p "This breed is not in the database."
		end
	end

	def self.user_breed_search
		name = greeting_and_get_name
		owner = Owner.find {|owner| owner["name"] == name}
		if owner
			puts "Welcome, #{name}."
			ask_for_input
		elsif !owner && make_an_account?
			new_account_name = ask_for_new_account_name
			if !(Owner.find {|owner| owner["name"] == new_account_name})
			Owner.create(name: new_account_name)
			puts "Welcome, #{new_account_name}."
			ask_for_input
			end
		end
		make_space(5)
		puts "[0] => Return"
		if gets.chomp == "0"
			main_menu
		end
	end

	def self.adopt_a_fresh_cat
		name = greeting_and_get_name
		owner = Owner.find {|owner| owner["name"] == name}
		if owner
			breed = get_breed_from_user
			breed_info = get_all(breed)
			if breed_info
				puts "What sex would you prefer for you new cat?"
				puts "M for male, F for female."
				new_cat_sex = gets.chomp.titleize
				puts "What name would you like to give this cat?"
				puts "You need not choose a name at this time."
				new_cat_name = gets.chomp
				new_cat = Cat.create(name: new_cat_name, sex: new_cat_sex, breed: breed_info["name"], temperament: breed_info["temperament"], life_span: breed_info["life_span"], description: breed_info["description"], indoor: breed_info["indoor"])
				Adoption.create(cat_id: new_cat.id, owner_id: owner.id, date_of_adoption: DateTime.now.strftime('%m/%d/%Y'), signature: name.split(" ").map {|n| n.chr + "."}.join(""))
				make_space(5)
				puts "The adoption papers have been finalized. Congratulations on the new kitty!"
			elsif !breed_info
				puts "This breed does not exist in the MVPAC database."
			end
		elsif !owner && make_an_account?
			new_account_name = ask_for_new_account_name
			if !(Owner.find {|owner| owner["name"] == new_account_name})
				Owner.create(name: new_account_name)
				puts "Welcome, #{new_account_name}."
				adopt_a_fresh_cat
			end
		end
		make_space(5)
		puts "[0] => Return"
		if gets.chomp == "0"
			main_menu
		end
	end
	
	def self.change_cats_name
		name = greeting_and_get_name
		owner = Owner.find {|owner| owner["name"] == name}
		if owner
			puts "Which cat is getting a new name?"
			owners_cats_name = gets.chomp
			owners_cat = Cat.find {|cat| cat["name"] = owners_cats_name}
			puts "What will be this cat's new name?"
			cats_new_name = gets.chomp
			owners_cat.update(name: cats_new_name)
		elsif !owner && make_an_account?
			new_account_name = ask_for_new_account_name
			if !(Owner.find {|owner| owner["name"] == new_account_name})
				Owner.create(name: new_account_name)
				puts "Welcome, #{new_account_name}."
			end
		end
		make_space(5)
		puts "[0] => Return"
		if gets.chomp == "0"
			main_menu
		end
	end

	def self.put_cat_up_for_adoption
		name = greeting_and_get_name
		owner = Owner.find {|owner| owner["name"] == name}
		if owner
			puts "Enter the name of the cat you are putting up for adoption."
			owners_cat_name = gets.chomp
			owners_cat = Cat.find {|cat| cat["name"] == owners_cat_name}
			puts "Are you certain you want to put #{owners_cat_name} up for adoption?"
			puts "Yes or No."
			response = gets.chomp.titleize
			if response == "Yes"
				owners_cat.destroy
				puts "The paper work has been finalized. Good day."
			elsif response == "No"
				nil
			else
				nil
			end
		elsif !owner
			puts "You do not have an acccount with the MVPAC."
			puts "An account with us is necessary to put a cat up for adoption."
			puts "Would you like to make an anccount?"
			puts "Yes or No."
			answer = gets.chomp.titleize
			if make_an_account
				new_account_name = ask_for_new_account_name
				owner = Owner.find {|owner| owner["name"] == new_account_name}
				if owner
					puts "There is already an account by this name."
				elsif !owner
					Owner.create(name: new_account_name)
					puts "Welcome, #{new_account_name}."
				end
			elsif !make_an_account
				nil
			end
		end
		make_space(5)
		puts "[0] => Return"
		if gets.chomp == "0"
			main_menu
		end
	end
end
