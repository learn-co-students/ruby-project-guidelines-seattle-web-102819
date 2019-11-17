class AddSignatureToAdoptions < ActiveRecord::Migration[5.2]
  def change
    add_column :adoptions, :signature, :string
  end
end
