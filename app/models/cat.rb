class Cat < ActiveRecord::Base
	has_many :adoptions
	has_many :owners, through: :adoptions
end

      # t.integer :weight
      # t.boolean :experimental
      # t.boolean :hairless
      # t.boolean :short_legs
			# t.boolean :hypoallergenic
			# t.integer :adaptability
      # t.integer :affection_level
      # t.integer :child_friendly
      # t.integer :dog_friendly
      # t.integer :energy_level
      # t.integer :grooming
      # t.integer :health_issues
      # t.integer :intelligence
      # t.integer :shedding_level
      # t.integer :social_needs
      # t.integer :stranger_friendly
      # t.integer :vocalisation
      # t.string :wikipedia_url
      