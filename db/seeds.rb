require 'rest-client'
require 'json'
require 'pry'
require_relative '../config/environment'
require_all 'app'

Owner.create(name: "Robinson", age: 21)
Owner.create(name: "Soundarya", age: 88)
Owner.create(name: "Tanner", age: 27)
Owner.create(name: "Yohanny", age: 52)
Owner.create(name: "Michael", age: 27)
Owner.create(name: "Tiffany", age: 27)
Owner.create(name: "Hal", age: 102)
Owner.create(name: "Devin", age: 52)
Owner.create(name: "Matt", age: 1000000)
Owner.create(name: "Taylor", age: 5)

# Cat.create(name: , sex: , breed: , temperament: , life_span: , description: , indoor:)

#	Adoption.create(cat_id: , owner_id: , date_of_adoption: , signature: )

# binding.pry
# 0
