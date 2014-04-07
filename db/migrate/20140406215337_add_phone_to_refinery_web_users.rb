class AddPhoneToRefineryWebUsers < ActiveRecord::Migration
  def change
    add_column :refinery_web_users, :phone_number, :string
  end
end
