module Refinery
  module LegislatorLookups
    class LegislatorLookup < Refinery::Core::BaseModel
      self.table_name = 'refinery_legislator_lookups'

      attr_accessible :zipcode, :position

      # def message was created automatically because you didn't specify a text field
      # when you ran the refinery:form generator. <3 <3 Refinery CMS.
      def message
        "Override def message in vendor/extensions/legislator_lookups/app/models/refinery/legislator_lookups/legislator_lookup.rb"
      end

      alias_attribute :name, :zipcode

      # Add some validation here if you want to validate the user's input
      # We have validated the first string field for you.
      validates :zipcode, :presence => true
    end
  end
end
