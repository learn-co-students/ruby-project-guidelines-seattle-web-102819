class CreateAdoptions < ActiveRecord::Migration[5.2]
  def change
    create_table :adoptions do |t|
      t.integer :cat_id
      t.integer :owner_id
      t.datetime :date_of_adoption
    end
  end
end
