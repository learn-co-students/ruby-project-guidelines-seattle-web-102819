require 'pry'
require 'date'

# def mvpac_title
# end

class CLIMethods

	def get_the_date
		time = DateTime.now
		adoption_date = time.strftime('%m/%d/%Y')
	end

	# def self.verify
	# 	name = greeting_and_get_name
	# 	owner = Owner.find {|owner| owner["name"] == name}
	# end 

	# def initial
	# 	self[0,1]
	# end
	
	def self.greeting_and_get_name
		p "Welcome to the MVPAC (Minimal Viable People Adoption Center)."
		p "We specialize in the adoption of domestic cats from licensed breeders."
		puts ""
		puts ""
		p "Enter your name."
		gets.chomp.titleize
	end
	
	def self.make_an_account?
		p "This account does not exist. Would you like you make one?"
		p "Yes or No."
		answer = gets.chomp.titleize
		if answer == "Yes"
			true
		elsif answer == "No"
			false
		end
	end
	
	def self.ask_for_new_account_name
		p "Enter your name."
		p "Your input will be capitalized."
		gets.chomp.titleize
	end
	
	def self.get_breed_from_user
		p "Enter the name of a breed you are interested in."
		gets.chomp.titleize
	end

	def self.pick_users_brain
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

	def self.ask_for_input
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

	def self.user_breed_search
		name = greeting_and_get_name
		owner = Owner.find {|owner| owner["name"] == name}
		if owner
			p "Welcome, #{name}."
			ask_for_input
		elsif !owner && make_an_account?
			new_account_name = ask_for_new_account_name
			if !(Owner.find {|owner| owner["name"] == new_account_name})
			Owner.create(name: new_account_name)
			p "Welcome, #{new_account_name}."
			ask_for_input
			end
		else
			nil
		end
	end

	def self.adopt_a_fresh_cat
		name = greeting_and_get_name
		owner = Owner.find {|owner| owner["name"] == name}
		if owner
			breed = get_breed_from_user
			breed_info = get_all(breed)
			if breed_info
				p "What sex would you prefer for you new cat?"
				p "M for male, F for female."
				new_cat_sex = gets.chomp.titleize
				p "What name would you like to give this cat?"
				p "You need not choose a name at this time."
				new_cat_name = gets.chomp
				new_cat = Cat.create(name: new_cat_name, sex: new_cat_sex, breed: breed_info["name"], temperament: breed_info["temperament"], life_span: breed_info["life_span"], description: breed_info["description"], indoor: breed_info["indoor"])
				Adoption.create(cat_id: new_cat.id, owner_id: owner.id)
			elsif !breed_info
				p "This breed does not exist in the MVPAC database."
			end
		elsif !owner && make_an_account?
			new_account_name = ask_for_new_account_name
			if !(Owner.find {|owner| owner["name"] == new_account_name})
				Owner.create(name: new_account_name)
				p "Welcome, #{new_account_name}."
			end
		end
	end

	# def self.adopt_a_previously_existing_cat
	# end
	
	def self.change_cats_name
		name = greeting_and_get_name
		owner = Owner.find {|owner| owner["name"] == name}
		if owner
			p "Which cat is getting a new name?"
			owners_cats_name = gets.chomp
			owners_cat = Cat.find {|cat| cat["name"] = owners_cats_name}
			p "What will be this cat's new name?"
			cats_new_name = gets.chomp
			owners_cat.update(name: cats_new_name)
		elsif !owner && make_an_account?
			new_account_name = ask_for_new_account_name
			if !(Owner.find {|owner| owner["name"] == new_account_name})
				Owner.create(name: new_account_name)
				p "Welcome, #{new_account_name}."
			end
		end
	end

	def self.put_cat_up_for_adoption
		name = greeting_and_get_name
		owner = Owner.find {|owner| owner["name"] == name}
		if owner
			p "Enter the name of the cat you are putting up for adoption."
			owners_cat_name = gets.chomp
			owners_cat = Cat.find {|cat| cat["name"] == owners_cat_name}
			p "Are you certain you want to put #{owners_cat_name} up for adoption?"
			p "Yes or No."
			response = gets.chomp.titleize
			if response == "Yes"
				owners_cat.destroy
			elsif response == "No"
				nil
			else
				nil
			end
		elsif !owner
			p "You do not have an acccount with the MVPAC."
			p "An account with us is necessary to put a cat up for adoption."
			p "Would you like to make an anccount?"
			p "Yes or No."
			answer = gets.chomp.titleize
			if make_an_account
				new_account_name = ask_for_new_account_name
				owner = Owner.find {|owner| owner["name"] == new_account_name}
				if owner
					p "There is already an account by this name."
				elsif !owner
					Owner.create(name: new_account_name)
					p "Welcome, #{new_account_name}."
				end
			elsif !make_an_account
				nil
			end
		end
	end
end
