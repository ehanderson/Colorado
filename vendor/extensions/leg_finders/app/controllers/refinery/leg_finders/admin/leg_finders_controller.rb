module Refinery
  module LegFinders
    module Admin
      class LegFindersController < Refinery::AdminController

        crudify :'refinery/leg_finders/leg_finder', 
                :title_attribute => "zip", 
                :order => "created_at DESC"

        def index
          unless searching?
            find_all_leg_finders
          else
            search_all_leg_finders
          end

          @grouped_leg_finders = group_by_date(@leg_finders)
        end

      end
    end
  end
end
