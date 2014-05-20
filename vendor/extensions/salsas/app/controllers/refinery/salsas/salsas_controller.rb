module Refinery
  module Salsas
    class SalsasController < ::ApplicationController

      before_filter :find_all_salsas
      before_filter :find_page
      before_filter :find_footer

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @salsa in the line below:
        present(@page)
        @enewsletters = Salsa.all.reverse

      end

      def show
        @salsa = Salsa.find(params[:id])
        present(@page)
      end

    protected

      def find_all_salsas
        @salsas = Salsa.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/salsas").first
      end

      def find_footer
        @footer = Refinery::Page.find_by_slug('footer')
      end

    end
  end
end
