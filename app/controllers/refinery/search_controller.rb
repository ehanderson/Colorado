module Refinery
  class SearchController < ::ApplicationController
    before_filter :find_footer

  	# Display search results given the query supplied
    def show
      @results = Refinery::SearchEngine.search(params[:query], params[:page])

      present(@page = Refinery::Page.find_by_link_url("/search"))
    end
    def find_footer
      @footer = Refinery::Page.find_by_slug('footer')
    end
  end
end
