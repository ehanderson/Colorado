module Refinery
  module Pages
    class SubMenuPresenter < MenuPresenter

      def initialize(collection, context)
        super
        self.max_depth = 1
      end
    end
  end
end
