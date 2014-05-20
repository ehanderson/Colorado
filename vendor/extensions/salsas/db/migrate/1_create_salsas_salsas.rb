class CreateSalsasSalsas < ActiveRecord::Migration

  def up
    create_table :refinery_salsas do |t|
      t.string :title
      t.string :date
      t.string :link
      t.string :blast_key
      t.string :author
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-salsas"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/salsas/salsas"})
    end

    drop_table :refinery_salsas

  end

end
