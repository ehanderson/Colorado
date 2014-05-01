class CreateLegFinders < ActiveRecord::Migration

  def up
    create_table :refinery_leg_finders do |t|
      t.string :zip

      t.timestamps
    end

    add_index :refinery_leg_finders, :id
  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "leg_finders"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/leg_finders"})
    end

    drop_table :refinery_leg_finders
  end

end
