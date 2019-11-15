require 'pry'
require 'date'

class CLIMethods

	def self.make_space(num)
		num.times do
			puts ""
		end
	end

	def self.mvpac_title
		make_space(50)
		puts "				 ________________________________________"
		puts "				 | Minimal Viable People Adoption Center |"
		puts "				 ________________________________________"
		make_space(4)
	end

	def self.main_menu
		mvpac_title
		puts "[1] => Learn about a particular breed of cat."
		puts ""
		puts "[2] => Adopt a kitten."
		puts ""
		puts "[3] => Update a your cat's name from in records."
		puts ""
		puts "[4] => Put your cat up for adoption."
		puts ""
		puts "[5] => List of available cat breeds."
		puts ""
		puts "[0] => Exit the program."
		make_space(14)

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
			elsif input == "5"
				mvpac_title
				get_breed_list
				make_space(4)
				puts "[0] => Main Menu"
				make_space(11)
				if gets.chomp == "0"
					main_menu
					break
				end
			elsif input == "0"
				puts "						GOODBYE!"
				abort
			else
				puts "Command not found."
				main_menu
				break
			end
		end
	end

	def self.greeting_and_get_name
		mvpac_title
		puts "Welcome to the MVPAC."
		make_space(1)
		puts "We specialize in the adoption of domestic cats from licensed breeders."
		make_space(1)
		puts "Enter your name."
		make_space(19)
		puts "[0] => Main Menu"
		gets.chomp.titleize
	end
	
	def self.make_an_account?
		mvpac_title
		puts "This account does not exist. Would you like you make one?"
		make_space(1)
		puts "Yes or No."
		make_space(1)
		puts "[0] => Main Menu"
		make_space(19)
		answer = gets.chomp.titleize
		if answer == "Yes"
			true
		elsif answer == "No"
			false
		elsif answer == "0"
			main_menu
			abort
		end
	end
	
	def self.ask_for_new_account_name
		puts "Enter your name."
		make_space(1)
		puts "Your input will be capitalized."
		make_space(14)
		puts "[0] => Main Menu"
		gets.chomp.titleize
	end
	
	def self.get_breed_from_user
		mvpac_title
		puts "Enter the name of a breed you are interested in."
		make_space(1)
		puts "If the breed is not in the database, you will be returned to the pervious screen."
		make_space(19)
		puts "[0] => Return"
		make_space(2)
		gets.chomp.titleize
	end

	def self.pick_users_brain
		mvpac_title
		puts "Every breed has stats. Choice which stats of the breed you are interested in."
		puts ""
		puts "[9] => All available information on the breed."
		puts ""
		puts "[1] => Temperament"
		puts ""
		puts "[2] => Life Span"
		puts ""
		puts "[3] => Description"
		puts ""
		puts "[4] => Outdoors?"
		puts ""
		puts "[0] => Main Menu."
		make_space(2)
		gets.chomp
	end

	def self.user_breed_search
		breed = get_breed_from_user
		while true
			if get_all(breed)
				case pick_users_brain
				when "1"
					mvpac_title
					get_temperament(breed)
					make_space(4)
					puts "[0] => Main Menu"
					if gets.chomp == "0"
						main_menu
						break
					end
				when "2"
					mvpac_title
					get_life_span(breed)
					make_space(4)
					puts "[0] => Main Menu"
					if gets.chomp == "0"
						main_menu
						break
					end
				when "3"
					mvpac_title
					get_description(breed)
					make_space(4)
					puts "[0] => Main Menu"
					if gets.chomp == "0"
						main_menu
						break
					end
				when "4"
					mvpac_title
					get_indoor(breed)
					make_space(4)
					puts "[0] => Main Menu"
					if gets.chomp == "0"
						main_menu
						break
					end
				when "9"
					mvpac_title
					get_all_scraped(breed)
					make_space(4)
					puts "[0] => Main Menu"
					if gets.chomp == "0"
						main_menu
						break
					end
				when "0"
					main_menu
					break
				else
					mvpac_title
					puts "You must enter a valid integer."
					make_space(4)
					puts "[0] => Main Menu"
					if gets.chomp == "0"
						main_menu
						break
					end
				end
			elsif breed = "0"
				main_menu
			else
				mvpac_title
				puts "This breed is not in the database."
				make_space(4)
				puts "[0] => Main Menu"
				if gets.chomp == "0"
					main_menu
					break
				end
			end
		end
	end

	def self.adopt_a_fresh_cat
		name = greeting_and_get_name
		owner = Owner.find {|owner| owner["name"] == name}
		while true
			if name == "0"
				main_menu
				break
			elsif owner
				breed = get_breed_from_user
				breed_info = get_all(breed)
				if breed_info
					mvpac_title
					puts "What sex would you prefer for you new cat?"
					make_space(1)
					puts "M for male, F for female."
					make_space(2)
					new_cat_sex = gets.chomp.titleize
					make_space(4)
					puts "What name would you like to give this cat?"
					make_space(1)
					puts "You need not choose a name at this time."
					new_cat_name = gets.chomp
					new_cat = Cat.create(name: new_cat_name, sex: new_cat_sex, breed: breed_info["name"], temperament: breed_info["temperament"], life_span: breed_info["life_span"], description: breed_info["description"], indoor: breed_info["indoor"])
					Adoption.create(cat_id: new_cat.id, owner_id: owner.id, date_of_adoption: DateTime.now.strftime('%m/%d/%Y'), signature: name.split(" ").map {|n| n.chr + "."}.join(""))
					make_space(4)
					puts "The adoption papers have been finalized. Congratulations on the new kitty!"
				elsif !breed_info
					mvpac_title
					make_space(4)
					puts "This breed does not exist in the MVPAC database."
					adopt_a_fresh_cat
					break
				elsif breed == "0"
					main_menu
					break
				end
			elsif !owner && make_an_account?
				new_account_name = ask_for_new_account_name
				if !(Owner.find {|owner| owner["name"] == new_account_name})
					Owner.create(name: new_account_name)
					make_space(4)
					puts "Welcome, #{new_account_name}."
					adopt_a_fresh_cat
					break
				end
			end
			make_space(4)
			puts "[0] => Main Menu"
			if gets.chomp == "0"
				main_menu
				break
			end
		end
	end
	
	def self.change_cats_name
		name = greeting_and_get_name
		owner = Owner.find {|owner| owner["name"] == name}
		while true
			if name == "0"
				main_menu
				break
			elsif owner
				mvpac_title
				puts "Which cat is getting a new name?"
				make_space(1)
				puts "If we have no record of you adopting this cat, you will be returned to the previous screen."
				make_space(2)
				owners_cats_name = gets.chomp
				owners_cat = Cat.find {|cat| cat["name"] = owners_cats_name}
				if owners_cat
					mvpac_title
					puts "What will be this cat's new name?"
					cats_new_name = gets.chomp
					owners_cat.update(name: cats_new_name)
					puts "#{owners_cats_name}'s name has been changed to #{cats_new_name}."
				elsif !(owners_cat)
					main_menu
					break
				end
			elsif !owner && make_an_account?
				new_account_name = ask_for_new_account_name
				if !(Owner.find {|owner| owner["name"] == new_account_name})
					Owner.create(name: new_account_name)
					puts "Welcome, #{new_account_name}."
					change_cats_name
					break
				end
			end
			make_space(5)
			puts "[0] => Return"
			if gets.chomp == "0"
				main_menu
				break
			end
		end
	end

	def self.put_cat_up_for_adoption
		name = greeting_and_get_name
		owner = Owner.find {|owner| owner["name"] == name}
		while true
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
					put_cat_up_for_adoption
					break
				else
					main_menu
					break
				end
			elsif !owner
				puts "You do not have an acccount with the MVPAC."
				puts "An account with us is necessary to put a cat up for adoption."
				puts "Would you like to make an anccount?"
				puts "Yes or No."
				answer = gets.chomp.titleize
				if make_an_account?
					new_account_name = ask_for_new_account_name
					owner = Owner.find {|owner| owner["name"] == new_account_name}
					if owner
						puts "There is already an account by this name."
						put_cat_up_for_adoption
						break
					elsif !owner && make_an_account?
						Owner.create(name: new_account_name)
						puts "Welcome, #{new_account_name}."
						put_cat_up_for_adoption
						break
					end
				end
			end
			make_space(5)
			puts "[0] => Return"
			if gets.chomp == "0"
				main_menu
				break
			end
		end
	end

end