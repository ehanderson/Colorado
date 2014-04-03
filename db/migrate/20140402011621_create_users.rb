class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :role
      t.string :first_name
      t.string :last_name
      t.string :organization
      t.string :title
      t.string :twitter_handle
      t.boolean :tweeter, default: false
      t.boolean :opinion_editorial, default: false
      t.boolean :letter_to_editor, default: false
      t.timestamps
    end
  end
end
