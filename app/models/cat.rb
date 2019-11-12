class Cat < ActiveRecord::Base
	has_many :adoptions
	has_many :owners, :through, :adoptions
end