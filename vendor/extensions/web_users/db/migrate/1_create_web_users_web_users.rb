class CreateWebUsersWebUsers < ActiveRecord::Migration

  def up
    create_table :refinery_web_users do |t|
      t.string :role
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :organization
      t.string :title
      t.string :twitter_handle
      t.boolean :tweeter
      t.boolean :opinion_editorial
      t.boolean :letter_to_editor
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-web_users"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/web_users/web_users"})
    end

    drop_table :refinery_web_users

  end

end
