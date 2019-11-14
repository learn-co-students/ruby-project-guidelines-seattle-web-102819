class AddBreedAndSexToCats < ActiveRecord::Migration[5.2]
  def change
    add_column :cats, :breed, :string
    add_column :cats, :sex, :string
  end
end
