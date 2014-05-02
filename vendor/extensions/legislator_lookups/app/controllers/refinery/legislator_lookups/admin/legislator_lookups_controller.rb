module Refinery
  module LegislatorLookups
    module Admin
      class LegislatorLookupsController < Refinery::AdminController

        crudify :'refinery/legislator_lookups/legislator_lookup', 
                :title_attribute => "zipcode", 
                :order => "created_at DESC"

        def index
          unless searching?
            find_all_legislator_lookups
          else
            search_all_legislator_lookups
          end

          @grouped_legislator_lookups = group_by_date(@legislator_lookups)
        end

      end
    end
  end
end
