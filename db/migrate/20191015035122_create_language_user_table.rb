class CreateLanguageUserTable < ActiveRecord::Migration[6.0]
  def change
    create_table :language_user do |t|
      t.references :language
      t.references :user
    end
  end
end
