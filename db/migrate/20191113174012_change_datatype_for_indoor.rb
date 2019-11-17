class ChangeDatatypeForIndoor < ActiveRecord::Migration[5.2]
  def change
    change_column :cats, :indoor, :integer
  end
end
