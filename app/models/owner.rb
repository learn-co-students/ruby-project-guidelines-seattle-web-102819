class Owner < ActiveRecord::Base
	has_many :adoptions
	has_many :cats, through: :adoptions
end
