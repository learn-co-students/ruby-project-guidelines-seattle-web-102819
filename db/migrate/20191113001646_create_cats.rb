class CreateCats < ActiveRecord::Migration[5.2]
  def change
    create_table :cats do |t|
      t.string :name
      t.string :temperament
      t.string :life_span
      t.string :description
      t.boolean :indoor
    end
  end
end
