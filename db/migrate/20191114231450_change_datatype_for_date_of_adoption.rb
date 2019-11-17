class ChangeDatatypeForDateOfAdoption < ActiveRecord::Migration[5.2]
  def change
    change_column :adoptions, :date_of_adoption, :string
  end
end
