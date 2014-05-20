module Refinery
  module Salsas
    module Admin
      class SalsasController < ::Refinery::AdminController

        crudify :'refinery/salsas/salsa',
                :xhr_paging => true

      end
    end
  end
end
