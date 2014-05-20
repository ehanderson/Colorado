class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :refinery_salsas, :date, :published
    rename_column :refinery_salsas, :link, :sent
  end
end
