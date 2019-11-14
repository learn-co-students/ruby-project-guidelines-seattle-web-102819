require_relative '../config/environment'
require_all 'lib'
require_all 'app'
require 'pry'

# binding.pry

name = greeting_and_get_name

if Owner.find {|owner| owner["name"] == name}
	ask_for_input
elsif !(Owner.find {|owner| owner["name"] == name}) && make_an_account?
	new_account_name = ask_for_account_name
	if !(Owner.find {|owner| owner["name"] == new_account_name})
	Owner.new(name: new_account_name)
	ask_for_input
	end
else
	nil
end
