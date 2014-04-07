module Refinery
  module WebUsers
    class WebUsersController < ::ApplicationController

      before_filter :find_all_web_users
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @web_user in the line below:
        present(@page)
      end

      def create
        binding.pry
        params[:web_user]
      end

      def show
        @web_user = WebUser.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @web_user in the line below:
        present(@page)
      end

    protected

      def find_all_web_users
        @web_users = WebUser.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/web_users").first
      end

    end
  end
end
