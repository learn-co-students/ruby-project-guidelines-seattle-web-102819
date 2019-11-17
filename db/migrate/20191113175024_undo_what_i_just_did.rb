class UndoWhatIJustDid < ActiveRecord::Migration[5.2]
  def change
    change_column :cats, :indoor, :boolean
  end
end
