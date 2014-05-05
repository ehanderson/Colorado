class AddLatLongToLegislatorLookup < ActiveRecord::Migration
  def change
    add_column :refinery_legislator_lookups, :address, :string
    add_column :refinery_legislator_lookups, :latitude, :float
    add_column :refinery_legislator_lookups, :longitude, :float
  end
end
