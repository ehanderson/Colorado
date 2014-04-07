module Refinery
  module WebUsers
    module Admin
      class WebUsersController < ::Refinery::AdminController

        crudify :'refinery/web_users/web_user',
                :title_attribute => 'role', :xhr_paging => true

      end
    end
  end
end
