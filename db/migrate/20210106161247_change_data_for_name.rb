class ChangeDataForName < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.remove :name
      t.string :first_name
      t.string :last_name
  end
end
