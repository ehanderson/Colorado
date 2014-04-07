class AddStoryToRefineryWebUsers < ActiveRecord::Migration
  def change
    add_column :refinery_web_users, :story, :text
  end
end
