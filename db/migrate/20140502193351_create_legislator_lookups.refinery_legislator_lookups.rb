# This migration comes from refinery_legislator_lookups (originally 1)
class CreateLegislatorLookups < ActiveRecord::Migration

  def up
    create_table :refinery_legislator_lookups do |t|
      t.string :zipcode

      t.timestamps
    end

    add_index :refinery_legislator_lookups, :id
  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "legislator_lookups"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/legislator_lookups"})
    end

    drop_table :refinery_legislator_lookups
  end

end
