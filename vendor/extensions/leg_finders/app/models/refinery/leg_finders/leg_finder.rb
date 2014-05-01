module Refinery
  module LegFinders
    class LegFinder < Refinery::Core::BaseModel
      self.table_name = 'refinery_leg_finders'

      attr_accessible :zip, :position

      def message
        "Override def message in vendor/extensions/leg_finders/app/models/refinery/leg_finders/leg_finder.rb"
      end

      alias_attribute :name, :zip
      validates :zip, :presence => true
    end
  end
end
